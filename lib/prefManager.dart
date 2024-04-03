import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager{
  final logger = Logger();

  // Method to save a string value in SharedPreferences
  static Future<void> saveString(String key,String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(key, value);


  }

  // Method to get the saved string value from SharedPreferences
  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   // logger.d("profile connection ${prefs.getString(key)}");

    return prefs.getString(key);
  }

  // Method to get the saved string value from SharedPreferences
  static Future<bool?> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // logger.d("profile connection ${prefs.getString(key)}");

    return prefs.getBool(key);
  }


  // Method to save a string value in SharedPreferences
  static Future<void> saveBool(String key,bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(key, value);


  }


  static Future<void> clearPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // logger.d("profile connection ${prefs.getString(key)}");
    prefs.clear();
    prefs.reload();
  }






}