import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:up_talks/helper/helperfunction.dart';
import 'package:up_talks/views/chatroom.dart';
import 'package:up_talks/views/signin.dart';
import 'package:up_talks/views/signup.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool? userIsLoggedIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getLoogedInState() async{
    await HelperFunctions.getUserLoggedInSharedPrefernce().then((value){
      setState(() {
        userIsLoggedIn = value;
      });

    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UpTalks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: userIsLoggedIn != null ? (userIsLoggedIn == true ? ChatRoom() : SignIn()) : SignIn(),

    );
  }
}
