import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heelingtouchproject/controllers/firebase_helper.dart';
import 'package:heelingtouchproject/controllers/route_helper.dart';
import 'package:heelingtouchproject/main.dart';
import 'package:no_context_navigation/no_context_navigation.dart';

import '../patient/auth/sign_in.dart';
import '../widgets/custom_dialog.dart';
// import '../patient/auth/verification_screen.dart';
// import 'package:heelingtouchproject/widgets/custom_dialog.dart';

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
          log("You are logged in successfully");

          // navKey.currentState.pushReplacementNamed(routeName);
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        log("${e.message}");
        e.message ==
                "A network error (such as timeout, interrupted connection or unreachable host) has occurred."
            ? Fluttertoast.showToast(
                msg: "Check Your Internet Connection",
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
        // setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP(
      String otp, String username, String phoneNumber, String password) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otp);
    log(verificationID);
    try {
      await firebaseAuth.signInWithCredential(credential).then(
        (value) {
          navService.pushNamed(MyHomePage1.routeName, args: 'From Home Screen');
        },
      ).whenComplete(
        () async {
          await FirestoreHelper.firestoreHelper.addUserToDB(
              firebaseAuth.currentUser!.uid, username, phoneNumber, password);
          verificationID = "";
          log(verificationID);
        },
      );
    } catch (err) {
      log(err.toString());
    }
  }

  String getUserId() {
    // log('user id= ${firebaseAuth.currentUser.uid}');
    // if (firebaseAuth.currentUser.uid == null) {
    //   log('no user added yet!');
    // }
    // return 'no user added yet';
    // } else {

    // try {
    // log(firebaseAuth.currentUser?.uid.toString());
    return firebaseAuth.currentUser!.uid;
    // } catch (e) {
    //   log('error from get user id: $e');
    // }
    // return "";
    // }
  }

// // ignore: missing_return
//   Future<Object> signup(String email, String password) async {
//     try {
//       UserCredential userCredential = await firebaseAuth
//           .createUserWithEmailAndPassword(email: email, password: password);
//       return userCredential;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         CustomDialoug.customDialoug
//             .showCustomDialoug('The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         CustomDialoug.customDialoug
//             .showCustomDialoug('The account already exists for that email.');
//       } else {
//         CustomDialoug.customDialoug
//             .showCustomDialoug('${e.code},check for any space');
//         // print('errooooooooor$e');
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//     return UserCredential;
//   }
//   // ignore: missing_return

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
          content: Text('user not found'),
          backgroundColor: Colors.red,
        );

        snackbarKey.currentState?.showSnackBar(snackBar);
      } else if (e.code == 'wrong-password') {
        log(e.code);
        const SnackBar snackBar = SnackBar(
          content: Text('Wrong password provided for that user.'),
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
      return false;
    } else {
      return true;
    }
  }
}
