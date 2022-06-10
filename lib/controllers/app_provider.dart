// import 'dart:developer';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heelingtouchproject/controllers/auth_helper.dart';
import 'package:heelingtouchproject/controllers/route_helper.dart';
import 'package:heelingtouchproject/model/Ads.dart';
import 'package:heelingtouchproject/model/articles.dart';
import 'package:heelingtouchproject/model/messege.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:heelingtouchproject/helpers/auth_helper.dart';
// import 'package:heelingtouchproject/helpers/route_helper.dart';
// import 'package:heelingtouchproject/main.dart';
// import 'package:heelingtouchproject/patient/auth/sign_in.dart';
// import 'package:heelingtouchproject/model/register_request.dart';
import 'package:heelingtouchproject/model/story.dart';
import 'package:heelingtouchproject/model/therapist.dart';
import 'package:heelingtouchproject/model/user_model.dart';
import 'package:heelingtouchproject/model/videos.dart';
import 'package:heelingtouchproject/patient/auth/sign_in.dart';
import 'package:heelingtouchproject/patient/pateint_home.dart';
import 'package:heelingtouchproject/patient/stories.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
// import 'package:heelingtouchproject/widgets/custom_dialog.dart';
import '../main.dart';
import '../widgets/custom_dialog.dart';
import 'firebase_helper.dart';

class AppProvider extends ChangeNotifier {
  late List<UserModel> users;
  late String myId;
  bool otpVisibility = false;

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController storyDescriptionController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController searchStoryisController = TextEditingController();

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
        // RouteHelper.routeHelper.goToPageWithReplacement(PatientHome.routeName);
      }
    }
  }

  AppProvider() {
    fetchStories();
    getTherapists();
    fetchAds();
    search();
    searchStrories();
    fetchArticles();
    fetchVideos();
  }
  List<Therapist> therapistsList = [];

  getTherapists() async {
    therapistsList = await FirestoreHelper.firestoreHelper.getTherapists();
    notifyListeners();
  }

  // Therapist therapist = Therapist(
  //     id: "id",
  //     fName: "fName",
  //     lName: "lName",
  //     bio: "bio",
  //     phonenumber: "phonenumber",
  //     img: "img",
  //     status: true,
  //     email: "password");
  // getTherapist(String id) async {
  //   therapist = await FirestoreHelper.firestoreHelper.getTherapist(id);
  //   notifyListeners();
  // }

  addStory() async {
    await FirestoreHelper.firestoreHelper.addStory(
        AuthHelper.authHelper.getUserId().toString(),
        storyDescriptionController.text);
    notifyListeners();
  }

  addConsultaion(String therpistID) async {
    await FirestoreHelper.firestoreHelper
        .requestConsultaion("ZtkOGoVnH2datRrIqPRfdtF2pH33", therpistID)
        .whenComplete(() {
      const SnackBar snackBar = SnackBar(
        content: Text('تم تاكيد طلبك بنجاح'),
        backgroundColor: Colors.green,
      );

      snackbarKey.currentState?.showSnackBar(snackBar);
    });
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

  List<Stroies> TherpistStoriesList = [];
  fetchTherpistStories(String id) async {
    TherpistStoriesList =
        await FirestoreHelper.firestoreHelper.fetchTherapistStoriesFuture(id);
    // log('user id cat ___ ${AuthHelper.authHelper.getUserId()}');
    // SpHelper.spHelper.setUserID(AuthHelper.authHelper.getUserId());
    isLoading = true;
    notifyListeners();
  }

  List<Article> articlesList = [];
  fetchArticles() async {
    articlesList = await FirestoreHelper.firestoreHelper.fetchArticlesFuture();
    // log('user id cat ___ ${AuthHelper.authHelper.getUserId()}');
    // SpHelper.spHelper.setUserID(AuthHelper.authHelper.getUserId());
    isLoading = true;
    notifyListeners();
  }

  List<Video> videosList = [];
  fetchVideos() async {
    videosList = await FirestoreHelper.firestoreHelper.fetchVideosFuture();
    // log('user id cat ___ ${AuthHelper.authHelper.getUserId()}');
    // SpHelper.spHelper.setUserID(AuthHelper.authHelper.getUserId());
    isLoading = true;
    notifyListeners();
  }

  List<Therapist> searchedTherapists = [];
  search() async {
    searchedTherapists = await FirestoreHelper.firestoreHelper
        .searchTherapists(searchController.text);
    notifyListeners();
  }

  List<Stroies> searchedStories = [];
  searchStrories() async {
    searchedStories = await FirestoreHelper.firestoreHelper
        .SearchStories(searchStoryisController.text);
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

  resetControllers() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
  }

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

  checkLogin() {
    bool isLoggedIn = AuthHelper.authHelper.checkUserLoging();
    if (isLoggedIn) {
      AuthHelper.authHelper.getUserId();
      log(AuthHelper.authHelper.getUserId().toString());
      navService.pushNamed(MyHomePage1.routeName, args: 'From Home Screen');
    } else {
      AuthHelper.authHelper.getUserId();
      log(AuthHelper.authHelper.getUserId().toString());
      log('user ID+++++++++++++++++++++++');
      navService.pushNamed(MyHomePage1.routeName, args: 'From Home Screen');
    }
  }

  logout() async {
    await AuthHelper.authHelper.logout();
    navService.pushNamedAndRemoveUntil(SignIn.routeName,
        args: 'From Home Screen');

    // RouteHelper.routeHelper.goToPageWithReplacement(Sign_In.routeName);
  }

  GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  late String userId;
  login1() async {
    try {
      UserCredential userCredinial = (await AuthHelper.authHelper.signin(
          emailController.text, passwordController.text)) as UserCredential;
      // FirestoreHelper.firestoreHelper
      //     .getUserFromFirestore(userCredinial.user!.uid);
      log(userCredinial.user!.uid);
      bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();

      log(isVerifiedEmail.toString());
      if (isVerifiedEmail) {
        //  .whenComplete(() =>

        navService.pushNamed(MyHomePage.routeName, args: 'From Home Screen');
        // )
        userId = userCredinial.user!.uid;
        FirestoreHelper.firestoreHelper
            .updateTherapistData(emailController.text, userCredinial.user!.uid);
        resetControllers();
        log('مششششششششش ايرور');
        // navKey.currentState!.pushReplacementNamed(MyHomePage.routeName);
      } else {
        log('errorrrrrrrrrrrrrrrrrrrrr ');
        sendVericiafion();
        // CustomDialoug.customDialoug.showCustomDialoug(
        //     'يجب عليك تاكيد حسابك من خلال البريد الالكتروني, هل تريد ارسال رابط التاكيد مجددا؟',
        //     sendVericiafion);
      }
    } catch (err) {
      const Center(child: CircularProgressIndicator());
      // if (err.toString() ==
      //     "type '_Type' is not a subtype of type 'UserCredential' in type cast") {
      //   const SnackBar snackBar = SnackBar(
      //     content: Text('please check your internet connection.'),
      //     backgroundColor: Colors.red,
      //   );
      //   snackbarKey.currentState?.showSnackBar(snackBar);
      // }
      log('errorrrrrrrrrrrrrrrrrrrrrrrrrrr $err');
    }
    // }

    // resetPassword() async {
    //   AuthHelper.authHelper.resetPassword(emailController.text);
    //   resetControllers();
    // }
  }

  createChatRoom(String time, String therapistID, String messege) async {
    MessageModel messageModel = MessageModel(
      content: messege,
      recieverId: therapistID,
      senderId: "ZtkOGoVnH2datRrIqPRfdtF2pH33",
      hour: "3:00",
    );
    await FirestoreHelper.firestoreHelper
        .CreateChatRoom(time, therapistID, messageModel);
    notifyListeners();
  }

  sendVericiafion() {
    AuthHelper.authHelper.verifyEmail();
    // AuthHelper.authHelper.logout();
  }
}
