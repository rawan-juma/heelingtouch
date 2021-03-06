import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/app_provider.dart';
import '../../widgets/app_button.dart';

// ignore: must_be_immutable
class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text('تغيير كلمة المرور',
                style: TextStyle(
                    fontFamily: 'NeoSansArabic',
                    color: const Color(0xffffffff),
                    fontSize: 13.sp),
                textAlign: TextAlign.center),
            backgroundColor: const Color(0xff2FA09C),
            // elevation: 2,
            shadowColor: Colors.grey[100],
            systemOverlayStyle: SystemUiOverlayStyle.light,
            leading: IconButton(
              icon: Image.asset("assets/Arrow - Right 2.png"),
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
            ),
          ),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(right: 5.w, top: 1.h),
                    child: Text(
                      "كلمة المرور القديمة",
                      style: TextStyle(
                          fontFamily: 'NeoSansArabic',
                          color: const Color(0xff2FA09C),
                          fontSize: 12.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.w, left: 5.w),
                    child: TextFormField(
                      controller: appProvider.currentPassController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.remove_red_eye_outlined,
                          color: Color(0xff2FA09C),
                        ),
                        // hintText: "******",
                        hintStyle: TextStyle(
                            fontFamily: 'NeoSansArabic',
                            fontSize: 11.sp,
                            color: const Color(0xff000000)),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(right: 5.w, top: 1.h),
                    child: Text(
                      "كلمة المرور الجديدة",
                      style: TextStyle(
                          fontFamily: 'NeoSansArabic',
                          color: const Color(0xff2FA09C),
                          fontSize: 12.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.w, left: 5.w),
                    child: TextFormField(
                      controller: appProvider.newPassController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      maxLines: 1,
                      // controller: descriptionController,
                      textAlign: TextAlign.right,

                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.remove_red_eye_outlined,
                          color: Color(0xff2FA09C),
                        ),
                        // hintText: "******",
                        hintStyle: TextStyle(
                            fontFamily: 'NeoSansArabic',
                            fontSize: 11.sp,
                            color: const Color(0xff000000)),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(right: 5.w, top: 1.h),
                    child: Text(
                      "تاكيد كلمة المرور",
                      style: TextStyle(
                          fontFamily: 'NeoSansArabic',
                          color: const Color(0xff2FA09C),
                          fontSize: 12.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.w, left: 5.w),
                    child: TextFormField(
                      controller: appProvider.confirmNewPassController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.remove_red_eye_outlined,
                          color: Color(0xff2FA09C),
                        ),
                        // hintText: "******",
                        hintStyle: TextStyle(
                            fontFamily: 'NeoSansArabic',
                            fontSize: 11.sp,
                            color: const Color(0xff000000)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h, bottom: 15.h),
                    child: App_Button('حفظ التعديلات', 90.w, () {
                      appProvider.changePassword();

                      log(appProvider.newPassController.text);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const Home()),
                      // );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
