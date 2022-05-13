import 'dart:async';
import 'package:flutter/material.dart';
import 'package:heelingtouchproject/main_screens/on_boarding.dart';
import 'package:sizer/sizer.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState;
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingScreen()),
            ));
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
