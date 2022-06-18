import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:heelingtouchproject/patient/about.dart';
import 'package:sizer/sizer.dart';

class PatientSettings extends StatefulWidget {
  const PatientSettings({Key? key}) : super(key: key);

  @override
  State<PatientSettings> createState() => _PatientSettingsState();
}

class _PatientSettingsState extends State<PatientSettings> {
  @override
  Widget build(BuildContext context) {
    bool status = false;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text('الإعدادات',
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
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 2.h, left: 4.w, right: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "الإشعارات",
                      style: TextStyle(
                          fontFamily: 'NeoSansArabic', fontSize: 12.sp),
                    ),
                    FlutterSwitch(
                      width: 40.0,
                      height: 20.0,
                      valueFontSize: 5.0,
                      toggleSize: 20.0,
                      value: true,
                      activeColor: const Color(0xff2FA09C),
                      inactiveColor: const Color(0xffDFDFDF),
                      activeToggleColor: const Color(0xffDFDFDF),
                      inactiveToggleColor: const Color(0xff2FA09C),
                      borderRadius: 10.0,
                      padding: 2.0,
                      showOnOff: status,
                      onToggle: (val) {
                        setState(() {
                          status = val;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                const Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutApp()),
                    );
                  },
                  child: Text(
                    "حول التطبيق",
                    style:
                        TextStyle(fontFamily: 'NeoSansArabic', fontSize: 12.sp),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                const Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "شروط الاستخدام",
                  style:
                      TextStyle(fontFamily: 'NeoSansArabic', fontSize: 12.sp),
                ),
                SizedBox(
                  height: 1.h,
                ),
                const Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ));
  }
}
