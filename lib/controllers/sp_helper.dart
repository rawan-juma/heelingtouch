import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  SpHelper._();
  static SpHelper spHelper = SpHelper._();
  SharedPreferences? sharedPreferences;

  initSharedPrefrences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // int x = 1+1;
  }

  setTherapistID(String userID) {
    sharedPreferences?.setString('userID', userID);
  }

  getTherapisID() {
    String? userID = sharedPreferences?.getString('userID');
    return userID;
  }

  setTherapistFname(String fName) {
    sharedPreferences?.setString('Fname', fName);
  }

  getTherapisFname() {
    String? userID = sharedPreferences?.getString('Fname');
    return userID;
  }

  setTherapistLname(String lName) {
    sharedPreferences?.setString('Lname', lName);
  }

  getTherapisIDLname() {
    String? userID = sharedPreferences?.getString('Lname');
    return userID;
  }

  setTherapistBio(String bio) {
    sharedPreferences?.setString('bio', bio);
  }

  getTherapisBio() {
    String? userID = sharedPreferences?.getString('bio');
    return userID;
  }

  setTherapistPhoneNumber(String phone) {
    sharedPreferences?.setString('phone', phone);
  }

  getTherapisPhoneNumber() {
    String? userID = sharedPreferences?.getString('phone');
    return userID;
  }

  setTherapistImg(String img) {
    sharedPreferences?.setString('img', img);
  }

  getTherapisImg() {
    String? userID = sharedPreferences?.getString('img');
    return userID;
  }
}
