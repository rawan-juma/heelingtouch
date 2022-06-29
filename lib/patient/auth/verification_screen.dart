import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import '../../controllers/app_provider.dart';
import '../../widgets/app_button.dart';

class Verification extends StatefulWidget {
  static const routeName = 'Verification';
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  String _code = "";
  @override
  Widget build(BuildContext context) {
    bool _onEditing = true;

    return Consumer<AppProvider>(builder: (context, authProvider, x) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            body: SizedBox(
          height: 100.h,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
                    )),
                Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: Text(
                    'التحقق من رقم الموبايل',
                    style: TextStyle(
                      color: const Color(0xff1D1D1D),
                      fontFamily: 'NeoSansArabic',
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 3.h, right: 12.w),
                  child: Image.asset(
                    'assets/verfication.png',
                    width: 70.w,
                    height: 32.h,
                    fit: BoxFit.fill,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 4.w, top: 5.h),
                      child: Text(
                        'لقد ارسالنا لك رمز التحقق إلى: ',
                        style: TextStyle(
                          color: const Color(0xff2FA09C),
                          fontFamily: 'NeoSansArabic',
                          fontSize: 11.sp,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Text(
                        '970${authProvider.phoneController.text}+',
                        style: TextStyle(
                          color: const Color(0xff2FA09C),
                          fontFamily: 'NeoSansArabic',
                          fontSize: 11.sp,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 3.h),
                    child: VerificationCode(
                      keyboardType: TextInputType.number,
                      underlineUnfocusedColor: Colors.grey,
                      underlineColor: Colors.grey,
                      itemSize: 55,
                      // length: 6,
                      digitsOnly: true,
                      fullBorder: true,
                      cursorColor: const Color(0xff2FA09C),
                      // autofocus: true,
                      onCompleted: (String value) {
                        _code = value;

                        log(_code);
                        setState(() {});
                      },
                      onEditing: (bool value) {
                        // setState(() {
                        _onEditing = value;
                        // });
                        if (!_onEditing) FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: App_Button("تأكيد", 90.w, () {
                    if (_code == "" || _code.length != 6) {
                      const SnackBar snackBar = SnackBar(
                        content: Text(".قم رجاءاً بإدخال كود التحقق اولاً"),
                        backgroundColor: Colors.red,
                      );
                      snackbarKey.currentState?.showSnackBar(snackBar);
                    } else {
                      authProvider.verifyNumber(_code);
                    }
                    log(_code);
                  }),
                ),
              ],
            ),
          ),
        )),
      );
    });
  }
}
