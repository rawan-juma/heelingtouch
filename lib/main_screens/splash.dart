import 'dart:async';
import 'package:flutter/material.dart';
import 'package:heelingtouchproject/controllers/auth_helper.dart';
import 'package:heelingtouchproject/main_screens/on_boarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // Future checkFirstSeen() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool _seen = (prefs.getBool('seen') ?? false);

  //   if (_seen) {
  //     AuthHelper.authHelper.checkUserLoging();
  //   } else {
  //     await prefs.setBool('seen', true);
  // Navigator.of(context).pushReplacement(
  // MaterialPageRoute(builder: (context) => const OnboardingScreen()));
  //   }
  // }

  @override
  void initState() {
    super.initState;

    Timer(const Duration(seconds: 3), () {
      // checkFirstSeen();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff20B2AF),
        body: Center(
          child: Image.asset(
            'assets/appIcon.png',
            height: 30.h,
            width: 30.w,
          ),
        ));
  }
}
