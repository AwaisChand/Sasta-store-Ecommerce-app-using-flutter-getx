import 'package:shared_preferences/shared_preferences.dart';

class SHAREDPREF {
  static late SharedPreferences prefs;

  factory SHAREDPREF() => SHAREDPREF._internal();

  SHAREDPREF._internal();

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static setUserId(String value) {
    prefs.setString('tutorId', value);
  }

  static getUserId() {
    return prefs.getString('tutorId') ?? '';
  }

  static setToken(String value) {
    prefs.setString('token', value);
  }

  static getToken() {
    return prefs.getString('token');
  }

  ///set login
  static setLoggedInStatus(bool? val) {
    prefs.setBool('isLoggedIn', val ?? true);
  }

  ///get login details
  static getLoggedInStatus() {
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
