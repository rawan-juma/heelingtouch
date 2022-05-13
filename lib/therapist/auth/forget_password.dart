import 'package:flutter/material.dart';
import 'package:heelingtouchproject/widgets/app_button.dart';
import 'package:heelingtouchproject/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              alignment: Alignment.topRight,
              height: 22.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  'assets/topwavee.png',
                ),
                fit: BoxFit.fill,
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
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    )),
              )),
          Padding(
            padding: EdgeInsets.only(right: 4.w),
            child: Text(
              'إسترجاع كلمة المرور',
              style: TextStyle(
                fontSize: 18.sp,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Center(
            child: Image.asset(
              'assets/forgetpassword.png',
              width: 75.w,
              height: 35.h,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: CustomTextField('البريد الالكتروني', emailController,
                TextInputType.emailAddress),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: App_Button('ارسال كلمة المرور', 90.w, () {}),
          ),
        ],
      ),
    ));
  }
}
