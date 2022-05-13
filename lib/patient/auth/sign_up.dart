// ignore_for_file: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heelingtouchproject/controllers/app_provider.dart';
import 'package:heelingtouchproject/patient/auth/sign_in.dart';
import 'package:heelingtouchproject/patient/auth/verification_screen.dart';
import 'package:heelingtouchproject/widgets/app_button.dart';
import 'package:heelingtouchproject/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  static const routeName = '/register';

  const SignUp({Key? key}) : super(key: key);
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, authProvider, x) {
      return Scaffold(
          body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                  )),
              Padding(
                padding: EdgeInsets.only(right: 4.w),
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    'إنشاء حساب',
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              CustomTextField('اسم المستخدم', authProvider.usernameController,
                  TextInputType.name),
              CustomTextField('رقم الهاتف', authProvider.phoneController,
                  TextInputType.number),
              CustomTextField(
                'كلمة المرور',
                authProvider.passwordController,
                TextInputType.visiblePassword,
                iconS: const Icon(
                  Icons.remove_red_eye_outlined,
                  color: Color(0xff2FA09C),
                ),
              ),
              // CustomTextField(
              //   'تأكيد كلمة المرور',
              //   passwordController,
              //   TextInputType.visiblePassword,
              //   iconS: const Icon(
              //     Icons.remove_red_eye_outlined,
              //     color: Color(0xff2FA09C),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: App_Button('إنشاء حساب', 90.w, () {
                  if (authProvider.usernameController.text.isEmpty ||
                      authProvider.phoneController.text.isEmpty ||
                      authProvider.passwordController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Please Enter all Fields !",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.yellow[200],
                        textColor: Colors.black,
                        fontSize: 14.sp);
                  }
                  // else if (authProvider.emailController.text.contains('@') ==
                  //         false ||
                  //     authProvider.emailController.text.contains('.') ==
                  //         false) {
                  //   Fluttertoast.showToast(
                  //       msg: "Please Enter Correct Email Format !",
                  //       toastLength: Toast.LENGTH_SHORT,
                  //       gravity: ToastGravity.BOTTOM,
                  //       timeInSecForIosWeb: 1,
                  //       backgroundColor: Colors.yellow[200],
                  //       textColor: Colors.black,
                  //       fontSize: 14.sp);
                  // }
                  else {
                    // log("message");
                    authProvider.register();
                    const Center(child: CircularProgressIndicator());
                    Timer(
                        const Duration(seconds: 3),
                        () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Verification()),
                            ));
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const Verification()));
                  }
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'لديك حساب؟',
                    style: TextStyle(
                      fontSize: 13.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    },
                    child: Text(
                      'تسجيل دخول',
                      style: TextStyle(
                          fontSize: 13.sp, color: const Color(0xff2FA09C)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 7.4.h),
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
    });
  }
}
