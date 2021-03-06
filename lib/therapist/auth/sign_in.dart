import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:heelingtouchproject/therapist/auth/forget_password.dart';
import 'package:heelingtouchproject/widgets/app_button.dart';
import 'package:heelingtouchproject/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/app_provider.dart';
import '../../controllers/fb_notifications.dart';
import '../../main.dart';

// ignore: must_be_immutable
class TherapistSignIn extends StatefulWidget {
  TherapistSignIn({Key? key}) : super(key: key);

  @override
  State<TherapistSignIn> createState() => _TherapistSignInState();
}

class _TherapistSignInState extends State<TherapistSignIn>
    with FbNotifications {
  @override
  void initState() {
    super.initState();
    initializeForegroundNotificationForAndroid();
    manageNotificationAction();
    requestNotificationPermissions();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _onLoading() {
      showDialog(
        context: context,
        barrierDismissible: false,
        // useRootNavigator: false,
        barrierColor: Colors.black26,
        builder: (BuildContext context) {
          return Center(
            child: Container(
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 68, 68, 68),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(
                    color: Color(0xff2FA09C),
                  ),
                )),
          );
        },
      );
    }

    return Consumer<AppProvider>(builder: (context, appProvider, x) {
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
                  '?????????? ????',
                  style: TextStyle(
                      color: const Color(0xff1D1D1D),
                      fontFamily: 'NeoSansArabic',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 4.w),
                child: Text(
                  '???? ???????????? ????????????',
                  style: TextStyle(
                    color: const Color(0xff1D1D1D),
                    fontFamily: 'NeoSansArabic',
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              CustomTextField('???????????? ????????????????????', appProvider.emailController,
                  TextInputType.emailAddress),
              CustomTextField(
                '???????? ????????????',
                appProvider.passwordController,
                TextInputType.visiblePassword,
                iconS: const Icon(
                  Icons.remove_red_eye_outlined,
                  color: Color(0xff2FA09C),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: App_Button('?????????? ????????????', 90.w, () {
                  if (appProvider.emailController.text.isEmpty ||
                      appProvider.passwordController.text.isEmpty) {
                    const SnackBar snackBar = SnackBar(
                      content: Text(
                        "!???? ???????????? ???????????? ???????? ????????????",
                        style: TextStyle(
                          fontFamily: 'NeoSansArabic',
                        ),
                        textAlign: TextAlign.right,
                      ),
                      backgroundColor: Colors.red,
                    );
                    snackbarKey.currentState?.showSnackBar(snackBar);

                    // Fluttertoast.showToast(
                    //     msg: "Please Fill all Fields !",
                    //     toastLength: Toast.LENGTH_SHORT,
                    //     gravity: ToastGravity.BOTTOM,
                    //     timeInSecForIosWeb: 1,
                    //     backgroundColor: Colors.red,
                    //     textColor: Colors.white,
                    //     fontSize: 14.sp);
                  } else if (appProvider.emailController.text.contains('@') ==
                          false ||
                      appProvider.emailController.text.contains('.') == false) {
                    const SnackBar snackBar = SnackBar(
                      content: Text(
                        ".???? ???????????? ???????????? ???????? ?????????? ??????????",
                        style: TextStyle(
                          fontFamily: 'NeoSansArabic',
                        ),
                        textAlign: TextAlign.right,
                      ),
                      backgroundColor: Colors.red,
                    );
                    snackbarKey.currentState?.showSnackBar(snackBar);
                  } else {
                    // Timer(const Duration(seconds: 3), () {});
                    appProvider.login1();
                    appProvider.isLoading = true;
                    if (appProvider.isLoading) {
                      _onLoading();
                    } else {
                      log("logged in successfully");
                    }
                  }
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const MyHomePage()),
                  // );
                }),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0.h),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgetPassword()),
                      );
                    },
                    child: Text(
                      '???????? ???????? ??????????????',
                      style: TextStyle(
                        color: const Color(0xff1D1D1D),
                        fontFamily: 'NeoSansArabic',
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.h),
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
