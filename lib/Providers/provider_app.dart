import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:soical_app/Screens/AddPostScreen/AddPostScreen.dart';
import 'package:soical_app/Screens/ChatsScreen/ChatsScreen.dart';
import 'package:soical_app/Screens/HomeScreen/HomeScreen.dart';
import 'package:soical_app/Screens/SettingsScreen/SettingsScreen.dart';
import 'package:soical_app/Screens/UsersScreen/UsersScreen.dart';
import 'package:soical_app/model/PostModel.dart';
import 'package:soical_app/screens_login_register/Login_Screen.dart';
import '../LayoutApp/LayoutApp.dart';
import '../widgets/Exception-dialog.dart';

class ProviderApp extends ChangeNotifier {
  bool obscureText = true;

  void changeStateObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }

  int currentIndexBottomBar = 0;
  void changeCurrentIndex(int newIndex, ctx) {
    if (newIndex == 2) {
      Navigator.push(ctx, MaterialPageRoute(builder: (_) {
        return AddPostScreen();
      }));
    } else {
      currentIndexBottomBar = newIndex;
      notifyListeners();
    }
  }

  List<Widget> screens = [
     HomeScreen(),
     const ChatsScreen(),
     AddPostScreen(),
    const UsersScreen(),
     SettingsScreen(),
  ];
  List<String> label = [
    "Home",
    "Chats",
    "Add Post",
    "Users",
    "Settings",
  ];

  String currentUserId = "0";

  void changeCurrentUserId(uid) {
    currentUserId = uid;
    notifyListeners();
  }

  bool loading = false;
  void changeLoading(bool newValue) {
    loading = newValue;
    notifyListeners();
  }

/*Start FirebaseAuth*/
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void createUser(BuildContext ctx, String username, String email,
      String password, String phone) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.credential == null) {
        addUser(userCredential.user!.uid, username, email, password, phone);
        changeLoading(false);
        Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (_) {
          return LoginScreen();
        }));
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "weak-password") {
        showDialog(
            context: ctx,
            builder: (BuildContext ctxBuilder) {
              return Exception_dialog(ctx, "weak-password");
            });
        changeLoading(false);
      } else if (error.code == "email-already-in-use") {
        showDialog(
            context: ctx,
            builder: (BuildContext ctxBuilder) {
              return Exception_dialog(ctx, "email-already-in-use");
            });
        changeLoading(false);
      }
    }
    notifyListeners();
  }

  void login(BuildContext ctx, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.credential == null) {
        changeLoading(false);
        changeCurrentUserId(userCredential.user!.uid);
        getUser(userCredential.user!.uid);
        Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (_) {
          return LayoutApp();
        }));
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "user-not-found") {
        showDialog(
            context: ctx,
            builder: (BuildContext ctxBuilder) {
              return Exception_dialog(ctx, "user-not-found");
            });
        changeLoading(false);
      } else if (error.code == "wrong-password") {
        showDialog(
            context: ctx,
            builder: (BuildContext ctxBuilder) {
              return Exception_dialog(ctx, "wrong-password");
            });
        changeLoading(false);
      }
    }
    notifyListeners();
  }

  void signOut(BuildContext ctx) async {
    firebaseAuth.signOut();
    Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (_) {
      return LoginScreen();
    }));
    notifyListeners();
  }

  /*End Start FirebaseAuth*/

/*Start FirebaseFirestore*/
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void addUser(String dserId, String username, String email, String password,
      String phone) {
    firebaseFirestore.collection("users").doc(dserId).set({
      "username": username,
      "email": email,
      "password": password,
      "phone": phone,
      "bio": "",
      "userImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvjNnRHsotlZ778n1rXmFxFL1Z5cCKl3-Ogw&usqp=CAU",
      "coverImage":
          "https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&w=1000&q=80",
    });
    notifyListeners();
  }

  Map<String, dynamic>? dataUser;
  void getUser(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> _documentSnapshot =
        await firebaseFirestore.collection("users").doc(uid).get();
    dataUser = _documentSnapshot.data();
    notifyListeners();
  }

  void updateUsernameAndBioAndPhone(
      String uid, String newName, String newBio, String newPhone) async {
    await firebaseFirestore.collection("users").doc(uid).update({
      "username": newName,
      "bio": newBio,
      "phone": newPhone,
    });
    getUser(uid);
    notifyListeners();
  }

  void createPost(String uid,
      String publisher,
      String urlImagePublisher,
      String date,
      String textPost,
      String urlImagePost,

      )async{
        await firebaseFirestore.collection("posts").add(
          {
            "uid":uid,
            "publisher":publisher,
            "urlImagePublisher":urlImagePublisher,
            "date":date,
            "textPost":textPost,
            "urlImagePost":urlImagePost,
            "n_like":0,
            "n_comments":0
          }
        );

  }


  List<PostModel> posts=[];
  void getAllPost(){
    firebaseFirestore.collection("posts").get().then((value){
      value.docs.forEach((element) {
        // print("elemet: ${element.data().toString()}");
        // PostModel post=new PostModel(
        //     element.get("textPost"),
        //     element.get("urlImagePost") ,
        //     element.get("date") ,
        //     element.get("n_comments") ,
        //     element.get("n_like") ,
        //     element.get("publisher"),
        //     element.get("uid") ,
        //     element.get("urlImagePublisher")
        // );

      });
    });
  }






  /*End FirebaseFirestore*/

  /*Start Image Picker*/

  ImagePicker picker = ImagePicker();

  File? profileImage;
  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      // print("${Uri.file(profileImage!.path).pathSegments.last}");
      notifyListeners();
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxWidth: double.infinity);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      notifyListeners();
    }
  }


  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxWidth: double.infinity);
    if (pickedFile != null) {
      postImage=File(pickedFile.path);
      notifyListeners();
    }
  }
  /*End Image Picker*/

/* Start firestorage*/

  firebase_storage.FirebaseStorage firebaseStorage =
      firebase_storage.FirebaseStorage.instance;

  void uploadeProfileImage(String uid) async {
    String urlImage = "";
    await firebaseStorage
        .ref()
        .child(
            "UsersImage_Profile/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) async {
      urlImage = await value.ref.getDownloadURL();
      notifyListeners();
      firebaseFirestore.collection("users").doc(uid).update({
        "userImage": urlImage,
      }).then((value) {
        getUser(uid);
      });
    }).catchError((e) {
      // print("===========${e.toString()}===============");
    });
    notifyListeners();
  }

  void uploadeCoverImage(String uid) async {
    String urlImage = "";
    await firebaseStorage
        .ref()
        .child(
            "UsersImage_Cover/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value) async {
      urlImage = await value.ref.getDownloadURL();
      notifyListeners();
      firebaseFirestore.collection("users").doc(uid).update({
        "coverImage": urlImage,
      }).then((value) {
        getUser(uid);
      });
    }).catchError((e) {
      // print("===========${e.toString()}===============");
    });
    notifyListeners();
  }


  void createNewPost(
      String date,
      String textPost,
      BuildContext context
     ) async {

    String? urlPostImage ;
    if(postImage!=null&&textPost.isNotEmpty){
      await firebaseStorage
          .ref()
          .child(
          "Posts_Images/${Uri.file(postImage!.path).pathSegments.last}")
          .putFile(postImage!)
          .then((value) async {
        urlPostImage = await value.ref.getDownloadURL();
        notifyListeners();
        await firebaseFirestore.collection("posts").add(
            {
              "uid":currentUserId,
              "publisher":dataUser!["username"],
              "urlImageUserName":dataUser!["userImage"],
              "date":date,
              "TextPost":textPost,
              "UrlImagePost":urlPostImage,
              "n_like":0,
              "n_comments":0
            }
        ).then((value) {
          print(value.id);
          postImage=null;
          changeLoadingPost(false);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){return LayoutApp();}));


        });
        notifyListeners();
      }).catchError((e) {
        // print("===========${e.toString()}===============");
      });
    }//done
    else if(postImage==null&&textPost.isNotEmpty){
      await firebaseFirestore.collection("posts").add({
        "uid":currentUserId,
        "publisher":dataUser!["username"],
        "urlImageUserName":dataUser!["userImage"],
            "date":date,
            "TextPost":textPost,
            "UrlImagePost":"no_image",
            "n_like":0,
            "n_comments":0
          }
      ).then((value) {
        changeLoadingPost(false);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){return LayoutApp();}));

      });

    }
    else if(postImage!=null&&textPost.isEmpty){
      await firebaseStorage
          .ref()
          .child(
          "Posts_Images/${Uri.file(postImage!.path).pathSegments.last}")
          .putFile(postImage!)
          .then((value) async {
        urlPostImage = await value.ref.getDownloadURL();
        notifyListeners();
        await firebaseFirestore.collection("posts").add(
            {
              "uid":currentUserId,
              "publisher":dataUser!["username"],
              "urlImageUserName":dataUser!["userImage"],
              "date":date,
              "TextPost":"empty",
              "UrlImagePost":urlPostImage,
              "n_like":0,
              "n_comments":0
            }
        ).then((value) {
          changeLoadingPost(false);
          postImage=null;
          notifyListeners();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){return LayoutApp();}));
        });
      }).catchError((e) {
        // print("===========${e.toString()}===============");
      });

    }//done
    else if(postImage==null&&textPost.isEmpty){
      changeLoadingPost(false);
       showDialog(
          context: context,
          builder: (BuildContext ctxBuilder) {
            return Exception_dialog(context, "لم يتم نشر البوست");
          });
    }//done
    notifyListeners();

  }

/* End firestorage*/

bool loadingPost=false;
void changeLoadingPost(bool newValue){
  loadingPost=newValue;
  notifyListeners();
}



}
