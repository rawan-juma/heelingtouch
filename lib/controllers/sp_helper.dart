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

  setArticleTitle(String title) {
    sharedPreferences?.setString('artTitle', title);
  }

  getArticleTitle() {
    String? userID = sharedPreferences?.getString('artTitle');
    return userID;
  }

  setArticleDescription(String description) {
    sharedPreferences?.setString('artDescription', description);
  }

  getArticleDescription() {
    String? userID = sharedPreferences?.getString('artDescription');
    return userID;
  }

  setArticleImg(String img) {
    sharedPreferences?.setString('artImg', img);
  }

  getArticleImg() {
    String? userID = sharedPreferences?.getString('artImg');
    return userID;
  }

  setStoryDescription(String description) {
    sharedPreferences?.setString('StoryDescription', description);
  }

  getStoryDescription() {
    String? userID = sharedPreferences?.getString('StoryDescription');
    return userID;
  }

  setStoryImg(String img) {
    sharedPreferences?.setString('StoryImg', img);
  }

  getStoryImg() {
    String? userID = sharedPreferences?.getString('StoryImg');
    return userID;
  }

  setPatientName(String img) {
    sharedPreferences?.setString('PatientName', img);
  }

  getPatientName() {
    String? userID = sharedPreferences?.getString('PatientName');
    return userID;
  }

  setPatientphone(String img) {
    sharedPreferences?.setString('Patientphone', img);
  }

  getPatientphone() {
    String? userID = sharedPreferences?.getString('Patientphone');
    return userID;
  }

  setPatientAddress(String img) {
    sharedPreferences?.setString('PatientAddress', img);
  }

  getPatientAddress() {
    String? userID = sharedPreferences?.getString('PatientAddress');
    return userID;
  }

  setPatientAge(String img) {
    sharedPreferences?.setString('PatientAge', img);
  }

  getPatientAge() {
    String? userID = sharedPreferences?.getString('PatientAge');
    return userID;
  }

  checkUser(bool pt) {
    sharedPreferences?.setBool("checkUser", pt);
  }

  getBool() {
    bool? check = sharedPreferences?.getBool('checkUser');
    return check;
  }
}
