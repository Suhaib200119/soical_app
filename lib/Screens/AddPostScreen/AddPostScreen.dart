
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soical_app/Providers/provider_app.dart';

class AddPostScreen extends StatelessWidget {
GlobalKey formKey=GlobalKey<FormState>();
TextEditingController tec_post_text=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var providerController=Provider.of<ProviderApp>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading:IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.blueAccent,),
        ) ,
        title:  Text("Create Post",style: TextStyle(color: Colors.blueAccent),),
        actions: [
          TextButton(onPressed: (){
            providerController.changeLoadingPost(true);
            DateTime date=DateTime.now();
          providerController.createNewPost(
              date.toString(),
              tec_post_text.text.trim().toString(),
            context
          );
          }, child: Text("Post"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:  NetworkImage("${providerController.dataUser!["userImage"]}"),
                    ),
                   SizedBox(width: 10,),
                   Text("${providerController.dataUser!["username"]}",style: TextStyle(
                        fontSize: 20
                    ),textAlign: TextAlign.center,),

                  ],
                ),
                Expanded(
                  child: Form(
                    key:formKey,
                    child: TextFormField(
                      controller:tec_post_text,
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "What is on your mind ... ",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(onPressed: (){
                    providerController.getPostImage();
                  }, child: Text("uploade image")),
                ),
                providerController.loadingPost==true?Padding(
                  padding: const EdgeInsets.all(10),
                  child: LinearProgressIndicator(),
                ):SizedBox(height: 2,),
              ],
            ),
      ),
    );

  }
}
