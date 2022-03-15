import 'package:flutter/material.dart';
import 'package:up_talks/Widgets/widget.dart';
import 'package:up_talks/helper/helperfunction.dart';
import 'package:up_talks/services/auth.dart';
import 'package:up_talks/services/database.dart';
import 'package:up_talks/views/chatroom.dart';
import 'package:up_talks/views/signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool _isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  HelperFunctions helperFunctions = new HelperFunctions();

  final formKey = GlobalKey<FormState>();

  TextEditingController userName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  

  signMeUp(){

    if(formKey.currentState!.validate()){

      Map<String, String> userInfoMap = {
        "name" : userName.text,
        "email" : email.text
      };

      HelperFunctions.saveUserEmailSharedPrefernce(email.text);
      HelperFunctions.saveUserNameSharedPrefernce(userName.text);

      setState(() {
        _isLoading = true;
      });


      authMethods.signUpWithEmailAndPassword(email.text, password.text).then((value) {
        print("${email.text}");

        databaseMethods.uploadUserInfo(userInfoMap);

        HelperFunctions.saveUserLoggedInSharedPrefernce(true);
        
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => ChatRoom()
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: _isLoading? Container(
        child: Center(child: CircularProgressIndicator()),
      ):
      SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 20,
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val){
                          return val!.isEmpty || val.length < 4 ? "Provide a valid userid" : null;
                        },
                        controller: userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                            hintText: "username",
                            hintStyle: TextStyle(
                              color: Colors.white54,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            )
                        ),
                      ),

                      TextFormField(
                        validator: (val){
                          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ? null : "Please provide a valid email Id";
                        },
                        controller: email,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          hintText: "email Id",
                          hintStyle: TextStyle(
                            color: Colors.white54,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val){
                          return val!.length > 6 ? null : "Provide a stronger password";
                        },
                        controller: password,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                            hintText: "password",
                            hintStyle: TextStyle(
                              color: Colors.white54,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            )
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 12,),

                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                GestureDetector(
                  onTap: (){
                    signMeUp();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [
                            Colors.blueAccent,
                            Colors.lightBlueAccent
                          ]
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.white70
                        ]
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Sign Up with Google",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an accout? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => SignIn()
                        ));
                      },
                      child: Text(
                        "Sign In Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60),
              ],
            ),
          ),
        ),
      )
    );
  }
}
