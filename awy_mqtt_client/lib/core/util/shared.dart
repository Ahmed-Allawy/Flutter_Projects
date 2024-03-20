import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static late SharedPreferences sharedpreferences;

  static init() async {
    sharedpreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({required String key}) {
    return sharedpreferences.get(key);
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedpreferences.setBool(key, value);
    }
    if (value is double) {
      return await sharedpreferences.setDouble(key, value);
    }
    if (value is String) {
      return await sharedpreferences.setString(key, value);
    }
    if (value is int) {
      return await sharedpreferences.setInt(key, value);
    } else {
      return await sharedpreferences.setStringList(key, value);
    }
  }

  static Future<bool> remove({required String key}) async {
    return await sharedpreferences.remove(key);
  }
}
