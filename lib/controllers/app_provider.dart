import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:heelingtouchproject/controllers/auth_helper.dart';
import 'package:heelingtouchproject/controllers/sp_helper.dart';
import 'package:heelingtouchproject/model/Ads.dart';
import 'package:heelingtouchproject/model/articles.dart';
import 'package:heelingtouchproject/model/chat.dart';
import 'package:heelingtouchproject/model/consultations.dart';
import 'package:heelingtouchproject/model/messege.dart';
import 'package:heelingtouchproject/model/story.dart';
import 'package:heelingtouchproject/model/therapist.dart';
import 'package:heelingtouchproject/model/user_model.dart';
import 'package:heelingtouchproject/model/videos.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import '../main.dart';
import '../main_screens/register_fb.dart';
import 'firebase_helper.dart';
import 'notification_helper.dart';

class AppProvider extends ChangeNotifier {
  // late List<UserModel> users;
  late String myId;
  bool otpVisibility = false;

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController storyDescriptionController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController searchStoryisController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController currentPassController = TextEditingController();
  TextEditingController confirmNewPassController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  register() {
    AuthHelper.authHelper.loginWithPhone(phoneController.text, otpVisibility);
    notifyListeners();
  }

  verifyNumber(String otp) async {
    AuthHelper.authHelper.verifyOTP(
      otp,
      usernameController.text,
      phoneController.text,
      addressController.text,
      ageController.text,
    );
    // await FirestoreHelper.firestoreHelper.getUser();
    // getUser();
    notifyListeners();
  }

  updateProfile() async {
    await FirestoreHelper.firestoreHelper.updatePatientData(
        usernameController.text,
        addressController.text,
        ageController.text,
        AuthHelper.authHelper.firebaseAuth.currentUser!.uid);
    await getUser();
    notifyListeners();
  }

  UserModel? user;
  String? username;
  String? img;
  String? phone;
  getUser() async {
    user = await FirestoreHelper.firestoreHelper.getUser();
    username = FirestoreHelper.firestoreHelper.userName;
    img = FirestoreHelper.firestoreHelper.img;
    phone = FirestoreHelper.firestoreHelper.phone;
    notifyListeners();
  }

  AppProvider() {
    fetchStories();
    getTherapists();
    fetchAds();
    search();
    searchStrories();
    searchArticle();
    fetchArticles();
    fetchVideos();
    getAllUsers();
    // checkLogin();
    // getUser();
  }
  List<Therapist> therapistsList = [];

  getTherapists() async {
    therapistsList = await FirestoreHelper.firestoreHelper.getTherapists();
    notifyListeners();
  }

  addStory() async {
    await FirestoreHelper.firestoreHelper.addStory(
        AuthHelper.authHelper.getUserId().toString(),
        storyDescriptionController.text);
    await getUser();
    notifyListeners();
  }

  addConsultaion(
      String therpistID, int year, int month, int day, int hour) async {
    await FirestoreHelper.firestoreHelper
        .requestConsultaion(AuthHelper.authHelper.firebaseAuth.currentUser!.uid,
            therpistID, year, month, day, hour)
        .whenComplete(() async {
      await NotificationHelper.notificationHelper.showNotification();
      const SnackBar snackBar = SnackBar(
        content: Text('تم تاكيد طلبك بنجاح'),
        backgroundColor: Colors.green,
      );

      snackbarKey.currentState?.showSnackBar(snackBar);
    });
    notifyListeners();
  }

  List<Consultaion> therapistConsultaionsList = [];
  getTherapistConsulations() async {
    therapistConsultaionsList =
        await FirestoreHelper.firestoreHelper.therapistConsultaions();
    notifyListeners();
  }

  List<Consultaion> patientConsultaionsList = [];
  getPatientConsulations() async {
    patientConsultaionsList =
        await FirestoreHelper.firestoreHelper.patientConsultaions();
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

  List<Stroies> therpistStoriesList = [];
  fetchTherpistStories(String id) async {
    therpistStoriesList =
        await FirestoreHelper.firestoreHelper.fetchTherapistStoriesFuture(id);
    // log('user id cat ___ ${AuthHelper.authHelper.getUserId()}');
    // SpHelper.spHelper.setUserID(AuthHelper.authHelper.getUserId());
    isLoading = true;
    notifyListeners();
  }

  List<Stroies> therpistStoriesList1 = [];
  fetchTherpistStories1() async {
    therpistStoriesList1 = await FirestoreHelper.firestoreHelper
        .fetchTherapistStoriesFuture(
            AuthHelper.authHelper.firebaseAuth.currentUser!.uid);
    // log('user id cat ___ ${AuthHelper.authHelper.getUserId()}');
    // SpHelper.spHelper.setUserID(AuthHelper.authHelper.getUserId());
    isLoading = true;
    // return therpistStoriesList;
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

  List<Article> searchedArticles = [];
  searchArticle() async {
    searchedArticles = await FirestoreHelper.firestoreHelper
        .searchArticles(searchController.text);
    notifyListeners();
  }

  List<Video> searchedVideos = [];
  searchVideo() async {
    searchedVideos = await FirestoreHelper.firestoreHelper
        .searchVideos(searchController.text);
    notifyListeners();
  }

  uploadImage() async {
    await FirestoreHelper.firestoreHelper.uploadImage();
    notifyListeners();
  }

  resetControllers() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  checkLogin() {
    bool isLoggedIn = AuthHelper.authHelper.checkUserLoging();
    if (isLoggedIn) {
      // AuthHelper.authHelper.getUserId();
      // log(AuthHelper.authHelper.getUserId().toString());
      // navService.pushNamed(MyHomePage1.routeName, args: 'From Home Screen');
    } else {
      AuthHelper.authHelper.getUserId();
      log(AuthHelper.authHelper.getUserId().toString());
      log('user ID+++++++++++++++++++++++');
      navService.pushNamed(MyHomePage1.routeName, args: 'From Home Screen');
    }
  }

  changePassword() async {
    AuthHelper.authHelper
        .changePassword(newPassController.text, currentPassController.text);
    notifyListeners();
  }

  logout() async {
    await AuthHelper.authHelper.logout();
    navService.pushNamedAndRemoveUntil(FirstRigestrePage.routeName,
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
        SpHelper.spHelper.checkUser(true);
        fetchTherpistStories1();
        getTherapistConsulations();
        resetControllers();
        log('مششششششششش ايرور');
        log(userCredinial.user!.uid.toString());
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

    // ignore: unused_element
  }

  // late Therapist therapist;
  // getTherapist() async {
  //   therapist = await FirestoreHelper.firestoreHelper.getTherapist();
  //   notifyListeners();
  // }

  updateTherapistProfileData() async {
    await FirestoreHelper.firestoreHelper.updateTherapistProfileData(
        AuthHelper.authHelper.firebaseAuth.currentUser!.uid,
        usernameController.text,
        " ",
        bioController.text,
        phoneController.text);
    notifyListeners();
  }

  resetPassword() async {
    AuthHelper.authHelper.resetPassword(emailController.text);
    resetControllers();
    notifyListeners();
  }

  createChatRoom(
      String patientName,
      String therapistName,
      String patientImg,
      String therapistImg,
      int time,
      String therapistID,
      String messege,
      String phone) async {
    MessageModel messageModel = MessageModel(
      content: "",
      recieverId: therapistID,
      senderId: AuthHelper.authHelper.firebaseAuth.currentUser!.uid,
      hour: time.toString(),
    );
    await FirestoreHelper.firestoreHelper.createChatRoom(
        patientName,
        therapistName,
        patientImg,
        therapistImg,
        time,
        therapistID,
        messageModel,
        phone);
    notifyListeners();
  }

  List<ChatRoom> chats = [];
  getChats() async {
    chats = await FirestoreHelper.firestoreHelper.fetchChats();
    notifyListeners();
  }

  List<MessageModel> messages = [];
  Future<List<MessageModel>> getMessages() async {
    messages = await FirestoreHelper.firestoreHelper.fetchmessages();
    notifyListeners();
    return messages;
  }

  updateChat(String senderID, String recieverID) async {
    await FirestoreHelper.firestoreHelper.updatemessages(
        messageController.text,
        senderID,
        recieverID,
        SpHelper.spHelper.getPatientID(),
        SpHelper.spHelper.getTherapisID(),
        "${DateTime.now().minute}:${DateTime.now().minute}");
  }

  List<UserModel> users = [];
  getAllUsers() async {
    users = await FirestoreHelper.firestoreHelper.getAllUsers();
    notifyListeners();
  }

  sendVericiafion() {
    AuthHelper.authHelper.verifyEmail();
    // AuthHelper.authHelper.logout();
  }
}
