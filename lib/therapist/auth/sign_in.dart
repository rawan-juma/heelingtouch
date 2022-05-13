// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:heelingtouchproject/therapist/auth/forget_password.dart';
import 'package:heelingtouchproject/widgets/app_button.dart';
import 'package:heelingtouchproject/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

import '../../main.dart';

// ignore: must_be_immutable
class TherapistSignIn extends StatelessWidget {
  TherapistSignIn({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                alignment: Alignment.topRight,
                height: 20.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    'assets/topwave.png',
                  ),
                  fit: BoxFit.cover,
                )),
                child: Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                )),
            Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: Text(
                'مرحبا بك',
                style: TextStyle(
                  fontSize: 18.sp,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: Text(
                'قم بتسجيل الدخول',
                style: TextStyle(
                  fontSize: 18.sp,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            CustomTextField('البريد الالكتروني', emailController,
                TextInputType.emailAddress),
            CustomTextField(
              'كلمة المرور',
              passwordController,
              TextInputType.emailAddress,
              iconS: const Icon(
                Icons.remove_red_eye_outlined,
                color: Color(0xff2FA09C),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: App_Button('تسجيل الدخول', 90.w, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.h),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgetPassword()),
                    );
                  },
                  child: Text(
                    'نسيت كلمة المرور؟',
                    style: TextStyle(
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.8.h),
              child: Image.asset(
                'assets/bottomwave.png',
                height: 20.h,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
