// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class ChatCustomTextField extends StatelessWidget {
  // final String hint;
  // Icon? iconS;
  // Icon? iconP;
  final TextEditingController controller;
  final TextInputType inputType;

  const ChatCustomTextField(this.controller, this.inputType, {Key? key})
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
                obscureText:
                    inputType == TextInputType.visiblePassword ? true : false,
                // inputType == TextInputType.visiblePassword ? (obscureText: true):(obscureText:false)
                controller: controller,
                keyboardType: inputType,
                textAlign: TextAlign.right,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  // labelText: hint,
                  labelStyle: TextStyle(
                      fontSize: 13.sp, color: const Color(0xff2FA09C)),
                  // suffixIcon: iconS,
                  // prefixIcon: iconP,
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
