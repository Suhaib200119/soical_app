import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../LayoutApp/LayoutApp.dart';
import '../../Providers/provider_app.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var keyForm = GlobalKey<FormState>();
    TextEditingController tec_name = new TextEditingController();
    TextEditingController tec_bio = new TextEditingController();
    TextEditingController tec_phone = new TextEditingController();

    var providerController = Provider.of<ProviderApp>(context);
    tec_name.text = providerController.dataUser!["username"];
    tec_bio.text = providerController.dataUser!["bio"];
    tec_phone.text = providerController.dataUser!["phone"];

    var profileIamge = providerController.profileImage;
    var coverIamge = providerController.coverImage;

    return Scaffold(
        appBar: AppBar(
          leading: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return LayoutApp();
                }));
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          title: Text("Edit Screen"),
          actions: [
            TextButton(
                onPressed: () {

                  providerController.updateUsernameAndBioAndPhone(
                      providerController.currentUserId,
                      "${tec_name.text.trim().toString()}",
                      "${tec_bio.text.trim().toString()}",
                      "${tec_phone.text.trim().toString()}");


                  if(profileIamge!=null){
                    providerController
                        .uploadeProfileImage(providerController.currentUserId);
                  }

                  if(coverIamge!=null){
                    providerController
                        .uploadeCoverImage(providerController.currentUserId);
                  }

                },
                child: Text(
                  "Update",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        coverIamge == null
                            ? Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image(
                                    image: NetworkImage(
                                        "${providerController.dataUser!["coverImage"]}"),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 200,
                                  ),
                                ),)
                            : Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image(
                                    image: FileImage(coverIamge),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 200,
                                  ),
                                )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  providerController.getCoverImage();
                                }),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: profileIamge == null
                              ? CircleAvatar(
                            radius: 68,
                                  backgroundImage: NetworkImage(
                                      "${providerController.dataUser!["userImage"]}"),
                                )
                              : CircleAvatar(
                            radius: 68,
                                  backgroundImage: FileImage(profileIamge),
                                ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                providerController.getProfileImage();
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(right: 10, left: 10, bottom: 0, top: 30),
                child: Form(
                    key: keyForm,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: tec_name,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              prefixIcon: Icon(Icons.person),
                              label: Text("Username")),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: tec_bio,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              prefixIcon: Icon(Icons.info_outline),
                              label: Text("Bio")),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: tec_phone,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              prefixIcon: Icon(Icons.phone),
                              label: Text("phone number")),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ));
  }
}
