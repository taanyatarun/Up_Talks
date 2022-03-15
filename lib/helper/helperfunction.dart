import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";


  static Future<bool> saveUserLoggedInSharedPrefernce(bool isUserLoggedIn) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPrefernce(String UserName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, UserName);
  }

  static Future<bool> saveUserEmailSharedPrefernce(String UserEmail) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, UserEmail);
  }


  static Future<bool?> getUserLoggedInSharedPrefernce() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String?> getUserNameSharedPrefernce() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserNameKey);
  }

  static Future<String?> getUserEmailLoggedInSharedPrefernce() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserEmailKey);
  }

}