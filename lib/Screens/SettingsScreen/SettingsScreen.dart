import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soical_app/Providers/provider_app.dart';
import 'package:soical_app/Screens/EditProfileScreen/EditProfileScreen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var providerController = Provider.of<ProviderApp>(context);
    return Column(
      children: [
        Container(
          height: 250,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image(
                    image: NetworkImage(
                        "${providerController.dataUser!["coverImage"]}"),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                ),
              ),
              CircleAvatar(
                radius: 65,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: CircleAvatar(
                  radius: 63,
                  backgroundImage: NetworkImage(
                      "${providerController.dataUser!["userImage"]}"),
                ),
              ),
            ],
          ),
        ),
        Text("${providerController.dataUser!["username"]}"),
        Text("${providerController.dataUser!["bio"]}"),
        SizedBox(height: 10,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text("100",style: TextStyle(fontWeight: FontWeight.w600),),
                Text(
                  "Posts",
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            Column(
              children: [
                Text("100",style: TextStyle(fontWeight: FontWeight.w600),),
                Text(
                  "Photos",
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            Column(
              children: [
    Text("100",style: TextStyle(fontWeight: FontWeight.w600),),
                Text(
                  "Followers",
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            Column(
              children: [
    Text("100",style: TextStyle(fontWeight: FontWeight.w600),),
                Text(
                  "Followings",
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: Row(
            children: [
              Expanded(
                  child: OutlinedButton(
                      onPressed: () {}, child: Text("add Photo"))),
              SizedBox(
                width: 5,
              ),
              OutlinedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx){return EditProfileScreen();}));
              }, child: Icon(Icons.edit)),
            ],
          ),
        )
      ],
    );
  }
}
