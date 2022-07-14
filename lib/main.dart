import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soical_app/Providers/provider_app.dart';
import 'package:soical_app/screens_login_register/Login_Screen.dart';

void main()async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MyApp());
}

class MyApp extends StatelessWidget  {
  Widget w= LoginScreen();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx){
        return ProviderApp()..getAllPost();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:LoginScreen(),
      ),
    );
  }
}


