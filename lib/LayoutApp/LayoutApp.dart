import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:soical_app/Providers/provider_app.dart';

class LayoutApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var providerController=Provider.of<ProviderApp>(context);
    return providerController.dataUser==null?Container(color: Colors.white,child: Center(child:  SpinKitCircle(color: Colors.blue, size:100 ))):Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        elevation: 0,
        backgroundColor: Colors.white10,
        title: Text("${providerController.label[providerController.currentIndexBottomBar]}",style: TextStyle(
          color: Colors.grey
        ),),
        actions: [
          IconButton(onPressed: (){
          }, icon: Icon(Icons.notifications),color: Colors.grey,),
          IconButton(onPressed: (){
          }, icon: Icon(Icons.search),color: Colors.grey,),
          IconButton(onPressed: (){
            providerController.signOut(context);
          }, icon: Icon(Icons.exit_to_app),color: Colors.grey,),
        ],
      ),
      drawer:Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text(providerController.dataUser!["username"]),
                accountEmail: Text(providerController.dataUser!["email"]),
                currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage(providerController.dataUser!["userImage"])),
            )
          ],
        ),
      ) ,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor:Colors.blue ,
        unselectedItemColor:Colors.grey ,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble),label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.file_upload_outlined),label: "AddPostScreen"),
          BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle_sharp),label: "Users"),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),



        ],
        currentIndex: providerController.currentIndexBottomBar,
        onTap: (int index){
          providerController.changeCurrentIndex(index,context);

        },
      ),
      body: providerController.screens[providerController.currentIndexBottomBar],
    );
  }
}
