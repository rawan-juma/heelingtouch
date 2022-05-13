import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  SpHelper._();
  static SpHelper spHelper = SpHelper._();
  SharedPreferences? sharedPreferences;

  initSharedPrefrences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // int x = 1+1;
  }

  setUserID(String userID) {
    sharedPreferences?.setString('userID', userID);
  }

  getUserID() {
    String? userID = sharedPreferences?.getString('userID');
    return userID;
  }
}
