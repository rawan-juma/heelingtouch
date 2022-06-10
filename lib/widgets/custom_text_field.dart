import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final String hint;
  Widget? iconS;
  Icon? iconP;
  int? length;
  final TextEditingController controller;
  final TextInputType inputType;

  CustomTextField(this.hint, this.controller, this.inputType,
      {Key? key, this.iconP, this.iconS, this.length})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return Consumer<AppProvider>(builder: (context, appProvider, x) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 1.h),
            child: SizedBox(
              height: 10.h,
              child: TextFormField(
                // inputType == TextInputType.visiblePassword ? (obscureText: true):(obscureText:false)
                controller: controller,
                obscureText:
                    inputType == TextInputType.visiblePassword ? true : false,
                keyboardType: inputType,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    fontFamily: 'NeoSansArabic', color: Colors.black),
                maxLength: length,
                decoration: InputDecoration(
                  counter: Offstage(),
                  labelText: hint,
                  labelStyle: TextStyle(
                      fontFamily: 'NeoSansArabic',
                      fontSize: 12.sp,
                      color: const Color(0xff2FA09C)),
                  suffixIcon: iconS,
                  prefixIcon: iconP,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff2FA09C)),
                  ),
                ),
              ),
            )));
    // });
  }
}
