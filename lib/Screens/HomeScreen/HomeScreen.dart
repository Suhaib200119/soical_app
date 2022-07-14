import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:soical_app/widgets/PostItem.dart';

import '../../Providers/provider_app.dart';
class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var providerController=Provider.of<ProviderApp>(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child:Image(
              image: NetworkImage("https://www.smallbusinesscomputing.com/wp-content/uploads/2021/07/DRL-ICA-071121-scaled.jpeg"),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
              ),
            StreamBuilder(
              stream: providerController.firebaseFirestore.collection("posts").snapshots(),
                builder: (ctx, snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(child: SpinKitCircle(color: Colors.blue, size:100 ));
                  }else if((snapshot.data! as QuerySnapshot).docs.isEmpty){
                    return const Center(child: Text("Ther is no any post"));
                  }else{
                    List<DocumentSnapshot> listDocs = (snapshot.data! as QuerySnapshot).docs;

                   return   ListView.builder(
                   shrinkWrap: true,
                      physics:  NeverScrollableScrollPhysics(),
                     itemCount: listDocs.length,
                     itemBuilder: (ctx,index){
                     return PostItem(
                         context: context,
                         username: listDocs[index].get("publisher"),
                         userImage:  listDocs[index].get("urlImagePublisher"),
                         date:  listDocs[index].get("date"),
                         textPost:  listDocs[index].get("textPost"),
                         imagePost: listDocs[index].get("urlImagePost"),
                         numberLike: listDocs[index].get("n_like"),
                         numberComments: listDocs[index].get("n_comments"));
                     },

                   );
                  }
                }
              ),
          ],

        ),

   
    );
  }
}
