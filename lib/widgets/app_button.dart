import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: camel_case_types, must_be_immutable
class App_Button extends StatelessWidget {
  String title;
// ignore: prefer_typing_uninitialized_variables
  final function;
  double w;
  App_Button(this.title, this.w, this.function, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 2.h),
        child: SizedBox(
          height: 8.h,
          width: w,
          child: ElevatedButton(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'NeoSansArabic',
                  fontSize: 13.sp,
                  color: const Color(0xffFFFFFF),
                ),
              ),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xff2FA09C)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Color(0xff2FA09C))))),
              onPressed: function),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class App_Button2 extends StatelessWidget {
  String title;
  final VoidCallback? function;
  double w;
  App_Button2(this.title, this.w, this.function, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 2.h),
        child: SizedBox(
          height: 8.h,
          width: w,
          child: ElevatedButton(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'NeoSansArabic',
                  fontSize: 13.sp,
                  color: const Color(0xff2FA09C),
                ),
              ),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xffffffff)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Color(0xff2FA09C))))),
              onPressed: function),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class App_Button3 extends StatelessWidget {
  String title;
  final VoidCallback? function;
  double w;
  App_Button3(this.title, this.w, this.function, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 6.h,
        width: w,
        child: ElevatedButton(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'NeoSansArabic',
                fontSize: 13.sp,
                color: const Color(0xffffffff),
              ),
            ),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xff2FA09C)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Color(0xff2FA09C))))),
            onPressed: function),
      ),
    );
  }
}
