import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heelingtouchproject/controllers/app_provider.dart';
import 'package:heelingtouchproject/controllers/firebase_helper.dart';
import 'package:heelingtouchproject/controllers/sp_helper.dart';
import 'package:heelingtouchproject/main.dart';
import 'package:heelingtouchproject/main_screens/register_fb.dart';
import 'package:heelingtouchproject/patient/auth/verification_screen.dart';
import 'package:no_context_navigation/no_context_navigation.dart';

class AuthHelper {
  AuthHelper._();

  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //bool otpVisibility = false;

  String verificationID = "";

  void loginWithPhone(String phoneNumber, bool otpVisibility) async {
    firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+970" + phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await firebaseAuth.signInWithCredential(credential).then((value) {
          // log("You are logged in successfully");
          const Center(child: CircularProgressIndicator());

          // navKey.currentState.pushReplacementNamed(routeName);
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        log("${e.message}");
        e.message ==
                "A network error (such as timeout, interrupted connection or unreachable host) has occurred."
            ? Fluttertoast.showToast(
                msg: "!قم بفحص الانترنت خاصتك",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              )
            : Fluttertoast.showToast(
                msg: "${e.message}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        log(verificationId);
        navService.pushNamed(Verification.routeName, args: 'From Home Screen');
        // setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP(
    String otp,
    String username,
    String phoneNumber,
    String address,
    String age,
  ) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otp);
    log(verificationID);
    try {
      await firebaseAuth.signInWithCredential(credential).then(
        (value) async {
          log(value.toString());
          navService.pushNamed(MyHomePage1.routeName, args: 'From Home Screen');
          await FirestoreHelper.firestoreHelper.addUserToDB(
            firebaseAuth.currentUser!.uid,
            username,
            phoneNumber,
            address,
            age,
          );
          SpHelper.spHelper.checkUser(false);
          // await FirestoreHelper.firestoreHelper.getUser();
          verificationID = "";
        },
      );
    } catch (err) {
      if (err.toString() ==
          "[firebase_auth/invalid-verification-code] The sms verification code used to create the phone auth credential is invalid. Please resend the verification code sms and be sure use the verification code provided by the user.") {
        const SnackBar snackBar = SnackBar(
          content: Text(
            '!الكود الذي قمت بادخاله خاطئ',
            style: TextStyle(
              fontFamily: 'NeoSansArabic',
            ),
            textAlign: TextAlign.right,
          ),
          backgroundColor: Colors.red,
        );
        snackbarKey.currentState?.showSnackBar(snackBar);
      } else {
        const SnackBar snackBar = SnackBar(
          content: Text(
            'هناك خطأ ما!',
            style: TextStyle(
              fontFamily: 'NeoSansArabic',
            ),
            textAlign: TextAlign.right,
          ),
          backgroundColor: Colors.red,
        );
        snackbarKey.currentState?.showSnackBar(snackBar);
      }
    }
  }

  String getUserId() {
    return firebaseAuth.currentUser!.uid;
  }

  // ignore: missing_return
  Future<Object> signin(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log(e.code);
        const SnackBar snackBar = SnackBar(
          content: Text(
            '!هذا الحساب غير موجود',
            style: TextStyle(
              fontFamily: 'NeoSansArabic',
            ),
            textAlign: TextAlign.right,
          ),
          backgroundColor: Colors.red,
        );

        snackbarKey.currentState?.showSnackBar(snackBar);
      } else if (e.code == 'wrong-password') {
        log(e.code);
        const SnackBar snackBar = SnackBar(
          content: Text(
            '!كلمة المرور خاطئة',
            style: TextStyle(
              fontFamily: 'NeoSansArabic',
            ),
            textAlign: TextAlign.right,
          ),
          backgroundColor: Colors.red,
        );
        snackbarKey.currentState?.showSnackBar(snackBar);
      }
    }
    return UserCredential;
  }

  resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
    // CustomDialoug.customDialoug.showCustomDialoug(
    //     'we have sent email for reset password, please check your email');
    // print('we have sent email for reset password, please check your email');
  }

  verifyEmail() async {
    await firebaseAuth.currentUser?.sendEmailVerification();
    // CustomDialoug.customDialoug.showCustomDialoug(
    //     'verification email has been sent, please check your email');
  }

  logout() async {
    firebaseAuth.signOut();
    log(firebaseAuth.signOut().toString());
  }

  bool checkEmailVerification() {
    return firebaseAuth.currentUser?.emailVerified ?? false;
  }

  bool checkUserLoging() {
    if (firebaseAuth.currentUser == null) {
      navService.pushNamed(FirstRigestrePage.routeName,
          args: 'From Home Screen');

      return false;
    } else {
      if (SpHelper.spHelper.getBool() == true) {
        navService.pushNamed(MyHomePage.routeName, args: 'From Home Screen');
        FirestoreHelper.firestoreHelper.therapistConsultaions();
        // getTherapistConsulations();
        FirestoreHelper.firestoreHelper
            .fetchTherapistStoriesFuture(firebaseAuth.currentUser!.uid);
      } else {
        navService.pushNamed(MyHomePage1.routeName, args: 'From Home Screen');
      }
      return true;
    }
  }

  changePassword(String currentPassword, String newPassword) async {
    try {
      //  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      User currentUser = firebaseAuth.currentUser!;
      if (newPassword != "") {
        await currentUser
            .updatePassword(newPassword)
            .then((value) => log("updated successfully"));
      } else {
        log("error message");
      }
    } catch (error) {
      log(error.toString());
    }
  }
}
