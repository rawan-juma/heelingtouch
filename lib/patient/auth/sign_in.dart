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

import '../../main.dart';

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
              child: SizedBox(
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
                                  color: const Color(0xff1D1D1D),
                                  fontFamily: 'NeoSansArabic',
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Text(
                              'قم بتسجيل الدخول',
                              style: TextStyle(
                                color: const Color(0xff1D1D1D),
                                fontFamily: 'NeoSansArabic',
                                fontSize: 16.sp,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        CustomTextField(
                          'رقم الهاتف',
                          authProvider.phoneController,
                          TextInputType.number,
                          length: 9,
                          iconS: Padding(
                            padding: EdgeInsets.only(top: 2.5.h),
                            child: Text(
                              "970+",
                              style: TextStyle(
                                  fontFamily: 'NeoSansArabic',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.sp),
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

                            if (authProvider.phoneController.text.isEmpty) {
                              const SnackBar snackBar = SnackBar(
                                content: Text(
                                  '!قم رجاءاً بادخال رقم الهاتف',
                                  style: TextStyle(
                                    fontFamily: 'NeoSansArabic',
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                backgroundColor: Colors.red,
                              );
                              snackbarKey.currentState?.showSnackBar(snackBar);
                            } else if ((authProvider
                                        .phoneController.text.length <
                                    9) ||
                                !(authProvider.phoneController.text
                                    .startsWith('59'))) {
                              const SnackBar snackBar = SnackBar(
                                content: Text(
                                  '.قم بادخال الرقم بشكل صحيح, حيث يبدا ب 59 ثم الرقم',
                                  style: TextStyle(
                                    fontFamily: 'NeoSansArabic',
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                backgroundColor: Colors.red,
                              );
                              snackbarKey.currentState?.showSnackBar(snackBar);
                            } else {
                              authProvider.register();
                              // .whenComplete(
                              //     () => Navigator.of(context).pushNamed("/Home"));

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const Verification()));
                            }
                          }),
                        ),
                      ],
                    ),
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
