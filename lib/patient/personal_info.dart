import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'edit_patient_profile.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text('معلوماتي الشخصية',
                  style: TextStyle(
                      color: const Color(0xffffffff), fontSize: 13.sp),
                  textAlign: TextAlign.center),
              backgroundColor: const Color(0xff2FA09C),
              // elevation: 2,
              shadowColor: Colors.grey[100], automaticallyImplyLeading: false,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              leading: IconButton(
                icon: Image.asset("assets/Arrow - Right 2.png"),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),

              actions: [
                IconButton(
                  icon: Image.asset("assets/editprofile.png"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditPatientProfile()),
                    );
                  },
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 2.h, left: 4.w, right: 4.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    Container(
                      alignment: Alignment.topRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "اسم المستخدم",
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: const Color(0xff2FA09C)),
                          ),
                          Text(
                            "الاء رائد بصل",
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "البريد الالكتروني",
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: const Color(0xff2FA09C)),
                          ),
                          Text(
                            "alaa@hotmail.com",
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "رقم الهاتف",
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: const Color(0xff2FA09C)),
                          ),
                          Text(
                            "0595555555",
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "العنوان",
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: const Color(0xff2FA09C)),
                          ),
                          Text(
                            "غزة - الثلاثيني",
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "العمر",
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: const Color(0xff2FA09C)),
                          ),
                          Text(
                            "22",
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.grey,
                    ),

                    //   ],
                    // )
                  ],
                ),
              ),
            )));
  }
}
