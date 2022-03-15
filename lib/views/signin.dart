import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:up_talks/Widgets/widget.dart';
import 'package:up_talks/services/auth.dart';
import 'package:up_talks/services/database.dart';
import 'package:up_talks/views/signup.dart';

import '../helper/helperfunction.dart';
import 'chatroom.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final formKey = GlobalKey<FormState>();

  AuthMethods authMethods = new  AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  TextEditingController userName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  bool isLoading = false;
  late QuerySnapshot<dynamic> snapshotUserInfo;

  sigInFunc(){

    HelperFunctions.saveUserEmailSharedPrefernce(email.text);

    if(formKey.currentState!.validate()){
      setState(() {
        isLoading = true;
      });

      databaseMethods.getUserByUserEmail(email.text)
      .then((val) {
        snapshotUserInfo = val;
        HelperFunctions
            .saveUserEmailSharedPrefernce(snapshotUserInfo.docs[0].data()["name"]);
      });

      authMethods.signInWithEmailAndPassword(email.text, password.text).then((val) {
        if(val != null){

          HelperFunctions.saveUserLoggedInSharedPrefernce(true);

          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatRoom()
          ));
        }
      });


    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 20,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val){
                          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ? null : "Email and password do not match";
                        },
                        controller: email,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
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
                        validator: (val){
                          return val!.length > 6 ? null : "Email and password do not match";
                        },
                        controller: password,
                        obscureText: true,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
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
                SizedBox(height: 8,),

                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  onTap: () {
                    sigInFunc();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blueAccent,
                          Colors.lightBlueAccent
                        ]
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),

                      child: Text(
                          "Sign In",
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
                    "Sign In with Google",
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
                        "Don't have an acconut? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => SignUp()
                        ));
                      },
                      child: Text(
                          "Register Now",
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
