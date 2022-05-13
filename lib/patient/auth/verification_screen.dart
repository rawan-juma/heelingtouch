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
            appBar: AppBar(
              centerTitle: true,
              title: Text('تأكيد رقم الهاتف',
                  style: TextStyle(
                      color: const Color(0xffffffff), fontSize: 13.sp),
                  textAlign: TextAlign.center),

              backgroundColor: const Color(0xff2FA09C),
              // elevation: 2,
              shadowColor: Colors.grey[100], automaticallyImplyLeading: false,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 10.h),
                    child: Text(
                      'تم ارسال كود تفعيل الى ${authProvider.phoneController.text}',
                      style: TextStyle(color: Colors.black45, fontSize: 12.sp),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    child: VerificationCode(
                      keyboardType: TextInputType.number,
                      length: 6,
                      autofocus: true,
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
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: App_Button("تأكيد", 330.w, () {
                      log(_code);
                      authProvider.verifyNumber(_code);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage1()));
                    }),
                  ),
                ],
              ),
            )),
      );
    });
  }
}
