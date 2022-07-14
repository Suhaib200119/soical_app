import 'package:flutter/material.dart';

import 'CustomeDivder.dart';

Widget PostItem({
  required BuildContext context,
  required String username,
  required String userImage,
  required String date,
  required String textPost,
  required String imagePost,
  required int numberLike,
  required int numberComments
}){
  return Card(
    elevation: 20,
      shadowColor: Colors.grey,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child:Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CircleAvatar(
                  backgroundImage: NetworkImage("${userImage}"),
                  radius: 30,
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("${username}",style: TextStyle(height: 1.5),),
                        SizedBox(width: 5,),
                        Icon(Icons.check_circle,color: Colors.blue,size: 17,)
                      ],
                    ),
                    Text("${date}",style: Theme.of(context).textTheme.caption?.copyWith(height: 1.5),)
                  ],
                ),
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz))
            ],
          ),
          CustomeDivder(height: 1,color: Colors.grey),
          if(textPost!="empty")Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Text("${textPost}",
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black,height: 1.5),
            ),
          ),
  SizedBox(height: 5,),
         if(imagePost!="no_image")Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child:Image(
              image: NetworkImage("${imagePost}"),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150,
            ),
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 30,
                  padding: EdgeInsets.all(5),
                  child: InkWell(
                    child: Row(
                      children: [
                        Icon(Icons.favorite,color: Colors.red,size: 20,),
                        SizedBox(width: 2,),
                        Text("${numberLike}",style: Theme.of(context).textTheme.caption,)
                      ],
                    ),
                    onTap: (){},
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 30,
                  padding: EdgeInsets.all(5),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.message,color: Colors.amber,size: 20,),
                        SizedBox(width: 2,),
                        Text("${numberLike} comments",style: Theme.of(context).textTheme.caption,)
                      ],
                    ),
                    onTap: (){},
                  ),
                ),
              ),

            ],
          ),
          CustomeDivder(height: 1,color: Colors.grey),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Row(
                      children: [
                        CircleAvatar(radius: 18,backgroundImage: NetworkImage("${userImage}"),),
                        SizedBox(width: 10,),
                        Text("Write Comment ...",style: Theme.of(context).textTheme.caption,),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Row(
                    children: [
                      Icon(Icons.favorite,color: Colors.red,),
                      Text("Like",style: Theme.of(context).textTheme.caption,)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )
  );
}