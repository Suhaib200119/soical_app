import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:soical_app/Providers/provider_app.dart';
import 'package:soical_app/screens_login_register/RegisterScreen.dart';

class LoginScreen extends StatelessWidget {



  var keyForm= GlobalKey<FormState>();
  TextEditingController tc_Email=TextEditingController();
  TextEditingController tc_Password=TextEditingController();




  @override
  Widget build(BuildContext context) {
    var providerConteroller=Provider.of<ProviderApp>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body:providerConteroller.loading?Center(
        child: SpinKitCircle(
          color: Colors.blue,
          size:100 ,
        ),): SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key:keyForm ,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Login Screen",style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey
                      ),),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: tc_Email,
                        keyboardType:TextInputType.emailAddress ,
                        validator: (String? inputUser){
                          if(inputUser!.isEmpty){
                            return "the email is required";
                          }else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          hintText: "Enter your email",
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: tc_Password,
                        keyboardType:TextInputType.visiblePassword ,
                        validator: (String? inputUser){
                          if(inputUser!.isEmpty){
                            return "the username is password";
                          }else{
                            return null;
                          }
                        },
                        obscureText:providerConteroller.obscureText,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            hintText: "Enter your password",
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(providerConteroller.obscureText?Icons.visibility:Icons.visibility_off),
                              onPressed: () {
                                providerConteroller.changeStateObscureText();
                                print("obscureText: ${providerConteroller.obscureText}");
                              },

                            )
                        ),

                      ),

                    ],
                  ),
                  SizedBox(height: 30,),
                  MaterialButton(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text("SignUp",style: TextStyle(
                            color: Colors.white,
                            fontSize: 24
                        ),),
                        width: 250,
                        height: 50,
                        color: Colors.blueGrey,
                      ),
                      onPressed: (){
                        if(keyForm.currentState!.validate()){
                          String email=tc_Email.text.trim();
                          String password=tc_Password.text.trim();
                          providerConteroller.changeLoading(true);

                          providerConteroller.login(context, email, password);
                        }

                      }
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.west,size: 30,color: Colors.blueGrey,),
                      SizedBox(width: 5,),
                      InkWell(
                        child: Text("Register Screen",style: TextStyle(fontSize: 18,color: Colors.grey),),
                        onTap: (){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(
                                  builder: (_){return RegisterScreen();}
                              ));
                        },
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}
