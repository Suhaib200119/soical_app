import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:soical_app/Providers/provider_app.dart';
import 'package:soical_app/screens_login_register/Login_Screen.dart';

class RegisterScreen extends StatelessWidget {



 var keyForm= GlobalKey<FormState>();
 TextEditingController tc_username=TextEditingController();
 TextEditingController tc_Email=TextEditingController();
 TextEditingController tc_Password=TextEditingController();
 TextEditingController tc_phone=TextEditingController();




 @override
  Widget build(BuildContext context) {
   var providerConteroller=Provider.of<ProviderApp>(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text("Register Screen"),
      ),
      body: providerConteroller.loading ?Center(
        child: SpinKitFadingCube(
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
                        Text("Register Screen",style: TextStyle(
                            fontSize: 34,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey
                        ),),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: tc_username,
                          keyboardType:TextInputType.name ,
                          validator: (String? inputUser){
                            if(inputUser!.isEmpty){
                              return "the username is required";
                            }else{
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            hintText: "Enter your username",
                            labelText: "Username",
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(height: 10,),
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
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: tc_phone,
                          keyboardType:TextInputType.phone ,
                          validator: (String? inputUser){
                            if(inputUser!.isEmpty){
                              return "the phone is required";
                            }else{
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            hintText: "Enter your phone",
                            labelText: "Phone",
                            prefixIcon: Icon(Icons.phone),
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
                          String username=tc_username.text.trim();
                          String email=tc_Email.text.trim();
                          String password=tc_Password.text.trim();
                          String phone=tc_phone.text.trim();
                          providerConteroller.changeLoading(true);
                          providerConteroller.createUser(context, username, email, password, phone);
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
                          child: Text("Login Screen",style: TextStyle(fontSize: 18,color: Colors.grey),),
                          onTap: (){
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_){
                                  return LoginScreen();}
                                ),
                            );
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
