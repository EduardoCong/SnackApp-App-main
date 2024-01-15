import 'package:shared_preferences/shared_preferences.dart';
class LocalStorageManager {
  static Future<void> saveLoggedInUserInfo(String clientName, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('clientName', clientName);
    prefs.setInt('id', id);
  }

  static Future<Map<String, dynamic>> getLoggedInUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? clientName = prefs.getString('clientName');
    int? id = prefs.getInt('id');

    return {'clientName': clientName, 'id': id};
  }

  static Future<void> clearLoggedInUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('clientName');
    prefs.remove('id');
  }
}

