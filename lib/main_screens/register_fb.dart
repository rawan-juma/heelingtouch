import 'package:flutter/material.dart';
import 'package:heelingtouchproject/patient/auth/sign_in.dart';
import 'package:heelingtouchproject/therapist/auth/sign_in.dart';
import 'package:heelingtouchproject/widgets/app_button.dart';
import 'package:sizer/sizer.dart';

class FirstRigestrePage extends StatelessWidget {
  const FirstRigestrePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Container(
                margin: EdgeInsets.only(top: 4.h),
                child: Image.asset(
                  'assets/registerFB.png',
                  width: 160.w,
                  height: 45.h,
                ),
              )),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'التسجيل كـ',
                style: TextStyle(
                    fontFamily: 'NeoSansArabic',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff2FA09C)),
              ),
              SizedBox(
                height: 2.h,
              ),
              App_Button('مريض', 90.w, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              }),
              App_Button2('أخصائي', 90.w, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TherapistSignIn()),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
