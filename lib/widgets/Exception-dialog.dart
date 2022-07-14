import 'package:flutter/material.dart';
import 'package:soical_app/screens_login_register/RegisterScreen.dart';

import '../screens_login_register/Login_Screen.dart';

Widget Exception_dialog(BuildContext ctx,String title){
  return AlertDialog(
    title: Text("Wrrong!"),
    content: Text(title),
    actions: [
      MaterialButton(
        child: Text("OK"),
          onPressed: (){
            Navigator.pop(ctx);

          }
      ),
    ],
  );
}