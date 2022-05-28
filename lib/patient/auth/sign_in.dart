// ignore_for_file: file_names

import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:heelingtouchproject/controllers/app_provider.dart';
import 'package:heelingtouchproject/patient/auth/sign_up.dart';
import 'package:heelingtouchproject/patient/auth/verification_screen.dart';
import 'package:heelingtouchproject/therapist/auth/forget_password.dart';
import 'package:heelingtouchproject/widgets/app_button.dart';
import 'package:heelingtouchproject/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class SignIn extends StatelessWidget {
  static const routeName = '/login';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SignIn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, authProvider, x) {
      return Scaffold(
          key: _scaffoldKey,
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Container(
                height: 100.h,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
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

                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Text(
                              'مرحبا بك',
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Text(
                              'قم بتسجيل الدخول',
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        CustomTextField(
                          'رقم الهاتف',
                          authProvider.phoneController,
                          TextInputType.number,
                          iconS: Padding(
                            padding: EdgeInsets.only(top: 2.5.h),
                            child: Text(
                              "970+",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12.sp),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: App_Button('تسجيل الدخول', 90.w, () {
                            // authProvider.signInUser();
                            // _scaffoldKey.currentState!.showSnackBar( SnackBar(
                            //   duration:  Duration(seconds: 4),
                            //   content:  Row(
                            //     children: <Widget>[
                            //        CircularProgressIndicator(),
                            //        Text("  Signing-In...")
                            //     ],
                            //   ),
                            // ));
                            authProvider.register();
                            // .whenComplete(
                            //     () => Navigator.of(context).pushNamed("/Home"));

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Verification()));
                            // if (authProvider.emailController.text.isEmpty ||
                            //     authProvider.passwordController.text.isEmpty) {
                            //   Fluttertoast.showToast(
                            //       msg: "Please Fill all Fields !",
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.BOTTOM,
                            //       timeInSecForIosWeb: 1,
                            //       backgroundColor: Colors.red,
                            //       textColor: Colors.white,
                            //       fontSize: 14.sp);
                            // } else if (authProvider.emailController.text.contains('@') ==
                            //         false ||
                            //     authProvider.emailController.text.contains('.') ==
                            //         false) {
                            //   Fluttertoast.showToast(
                            //       msg: "Please Enter Correct Email Format !",
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.BOTTOM,
                            //       timeInSecForIosWeb: 1,
                            //       backgroundColor: Colors.red,
                            //       textColor: Colors.black,
                            //       fontSize: 14.sp);
                            // } else {
                            //   authProvider.login1();
                            // }
                          }),
                        ),
                      ],
                    ),
                    // CustomTextField(
                    //   'كلمة المرور',
                    //   authProvider.passwordController,
                    //   TextInputType.visiblePassword,
                    //   iconS: const Icon(
                    //     Icons.remove_red_eye_outlined,
                    //     color: Color(0xff2FA09C),
                    //   ),
                    // ),

                    //
                    // Padding(
                    //   padding: EdgeInsets.only(top: 25.h),
                    //   child:
                    Image.asset(
                      'assets/bottomwave.png',
                      height: 20.h,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    // ),
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
