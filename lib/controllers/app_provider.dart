// import 'dart:developer';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heelingtouchproject/controllers/auth_helper.dart';
import 'package:heelingtouchproject/controllers/route_helper.dart';
import 'package:heelingtouchproject/model/Ads.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:heelingtouchproject/helpers/auth_helper.dart';
// import 'package:heelingtouchproject/helpers/route_helper.dart';
// import 'package:heelingtouchproject/main.dart';
// import 'package:heelingtouchproject/patient/auth/sign_in.dart';
// import 'package:heelingtouchproject/model/register_request.dart';
import 'package:heelingtouchproject/model/story.dart';
import 'package:heelingtouchproject/model/therapist.dart';
import 'package:heelingtouchproject/model/user_model.dart';
import 'package:heelingtouchproject/patient/pateint_home.dart';
// import 'package:heelingtouchproject/widgets/custom_dialog.dart';
import 'firebase_helper.dart';

class AppProvider extends ChangeNotifier {
  late List<UserModel> users;
  late String myId;
  bool otpVisibility = false;

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController storyDescriptionController = TextEditingController();

  register() {
    AuthHelper.authHelper.loginWithPhone(phoneController.text, otpVisibility);
    notifyListeners();
  }

  verifyNumber(String otp) {
    AuthHelper.authHelper.verifyOTP(otp, usernameController.text,
        phoneController.text, passwordController.text);
    notifyListeners();
  }

  signInUser() async {
    List<UserModel> users = await FirestoreHelper.firestoreHelper.getAllUsers();
    for (int i = 0; i <= users.length - 1; i++) {
      if (phoneController.text == users[i].phone &&
          passwordController.text == users[i].password) {
        Fluttertoast.showToast(
          msg: "${users[i].username}, ${users[i].phone}, ${users[i].id}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color.fromARGB(255, 0, 209, 28),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        RouteHelper.routeHelper.goToPageWithReplacement(PatientHome.routeName);
      }
    }
  }

  AppProvider() {
    fetchStories();
    getTherapists();
    fetchAds();
  }
  List<Therapist> therapistsList = [];

  getTherapists() async {
    therapistsList = await FirestoreHelper.firestoreHelper.getTherapists();
    notifyListeners();
  }

  Therapist therapist = Therapist(
      id: "id",
      fName: "fName",
      lName: "lName",
      bio: "bio",
      phonenumber: "phonenumber",
      img: "img",
      status: true,
      password: "password");
  getTherapist(String id) async {
    therapist = await FirestoreHelper.firestoreHelper.getTherapist(id);
    notifyListeners();
  }

  addStory() async {
    await FirestoreHelper.firestoreHelper
        .addStory(storyDescriptionController.text);
    notifyListeners();
  }

  List<Ads> adsList = [];
  fetchAds() async {
    adsList = await FirestoreHelper.firestoreHelper.fetchAdsFuture();
    // log('user id cat ___ ${AuthHelper.authHelper.getUserId()}');
    // SpHelper.spHelper.setUserID(AuthHelper.authHelper.getUserId());
    isLoading = true;
    notifyListeners();
  }

  bool isLoading = false;

  List<Stroies> storiesList = [];
  fetchStories() async {
    storiesList = await FirestoreHelper.firestoreHelper.fetchStoriesFuture();
    // log('user id cat ___ ${AuthHelper.authHelper.getUserId()}');
    // SpHelper.spHelper.setUserID(AuthHelper.authHelper.getUserId());
    isLoading = true;
    notifyListeners();
  }

  uploadImage() async {
    await FirestoreHelper.firestoreHelper.uploadImage();
    notifyListeners();
  }
  // getAllUsers() async {
  //   users = await FirestoreHelper.firestoreHelper.getAllUsersFromFirestore();
  //   users.removeWhere((element) => element.id == myId);
  //   notifyListeners();
  // }
  // TextEditingController phoneNumberController = TextEditingController();

  // fillControllers() {
  //   emailController.text = user.email;
  //   usernameController.text = user.username;
  // }

  // late UserModel user;
  // getUserFromFirestore() async {
  //   String? userId = AuthHelper.authHelper.getUserId();
  //   user = await FirestoreHelper.firestoreHelper.getUserFromFirestore(userId!);

  //   notifyListeners();
  // }

  // resetControllers() {
  //   usernameController.clear();
  //   emailController.clear();
  //   passwordController.clear();
  // }

  // updateProfile() async {
  //   try {
  //     UserModel userModel = UserModel(
  //         id: user.id,
  //         email: emailController.text,
  //         username: usernameController.text);

  //     await FirestoreHelper.firestoreHelper.updateProfile(userModel);
  //     getUserFromFirestore();
  //     // Navigator.of(RouteHelper.routeHelper.navKey.currentContext).pop();
  //   } catch (err) {
  //     // print(err);
  //   }
  // }

  // checkLogin() {
  //   bool isLoggedIn = AuthHelper.authHelper.checkUserLoging();
  //   if (isLoggedIn) {
  //     // myId = AuthHelper.authHelper.getUserId();
  //     getAllUsers();
  //     log('user ID+++++++++++++++++++++++');
  //     // RouteHelper.routeHelper
  //     //     .goToPageWithReplacement(FluidNavBarDemo.routeName);
  //   } else {
  //     log('user ID+++++++++++++++++++++++');
  //     // RouteHelper.routeHelper.goToPageWithReplacement(Sign_In.routeName);
  //   }
  // }

  // register() async {
  //   try {
  //     UserCredential? userCredinial = (await AuthHelper.authHelper.signup(
  //         emailController.text, passwordController.text)) as UserCredential?;
  //     RegisterRequest registerRequest = RegisterRequest(
  //       id: userCredinial!.user!.uid,
  //       email: emailController.text,
  //       username: usernameController.text,
  //     );
  //     await FirestoreHelper.firestoreHelper.addUserToFirestore(registerRequest);
  //     await AuthHelper.authHelper.verifyEmail();
  // CustomDialoug.customDialoug.showCustomDialoug(
  //     'يرجى تاكيد الحساب, سيتم ارساله بعد قليل عبر البريد الالكتروني',
  //     sendVericiafion);
  //     RouteHelper.routeHelper.goToPage(SignIn.routeName);
  //     resetControllers();
  //   } catch (err) {
  //     log('exceptionnnnnnnnnnnn///// $err');
  //   }
  // }

  // logout() async {
  //   await AuthHelper.authHelper.logout();
  //   // RouteHelper.routeHelper.goToPageWithReplacement(Sign_In.routeName);
  // }

  // // String userID;
  // login1() async {
  //   try {
  //     UserCredential userCredinial = (await AuthHelper.authHelper.signin(
  //         emailController.text, passwordController.text)) as UserCredential;
  //     FirestoreHelper.firestoreHelper
  //         .getUserFromFirestore(userCredinial.user!.uid);
  //     log(userCredinial.user!.uid);
  //     bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();
  //     log(isVerifiedEmail.toString());
  //     if (isVerifiedEmail) {
  //       RouteHelper.routeHelper.goToPageWithReplacement(MyHomePage1.routeName);
  //       resetControllers();
  //     } else {
  //       log('errorrrrrrrrrrrrrrrrrrrrr ');

  //       // CustomDialoug.customDialoug.showCustomDialoug(
  //       //     'يجب عليك تاكيد حسابك من خلال البريد الالكتروني, هل تريد ارسال رابط التاكيد مجددا؟',
  //       //     sendVericiafion);
  //     }
  //   } catch (err) {
  //     log('errorrrrrrrrrrrrrrrrrrrrrrrrrrr $err');
  //   }
  // }

  // sendVericiafion() {
  //   AuthHelper.authHelper.verifyEmail();
  //   AuthHelper.authHelper.logout();
  // }

  // resetPassword() async {
  //   AuthHelper.authHelper.resetPassword(emailController.text);
  //   resetControllers();
  // }

}
