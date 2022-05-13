// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/therapist/auth/edit_profile.dart';
import 'package:heelingtouchproject/therapist/notifications_screen.dart';
import 'package:heelingtouchproject/therapist/settings.dart';
import 'package:heelingtouchproject/therapist/story_details.dart';
import 'package:heelingtouchproject/widgets/app_button.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<String> imgs = [
    'assets/tt.png',
    'assets/tt.png',
    'assets/tt.png',
    'assets/tt.png',
    'assets/tt.png',
    'assets/tt.png',
    'assets/tt.png',
    'assets/tt.png',
    'assets/tt.png',
    'assets/tt.png',
    'assets/tt.png',
    'assets/tt.png',
    'assets/tt.png',
    'assets/tt.png',
    'assets/tt.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text('بروفايلي',
              style: TextStyle(color: const Color(0xffffffff), fontSize: 13.sp),
              textAlign: TextAlign.center),
          backgroundColor: Color(0xff2FA09C),
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
              icon: Image.asset("assets/Notification.png"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
            IconButton(
              icon: Image.asset("assets/Setting.png"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
            ),
          ],
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 4.w,
                    ),
                    Container(
                        width: 27.w,
                        height: 24.h,
                        decoration: const BoxDecoration(
                            color: Color(0xff2FA09C),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/personP.png"),
                            ))),
                    SizedBox(
                      width: 2.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "مريم سعيد",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'MULI'),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          "0590000000",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'MULI'),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        App_Button3('تعديل الملف الشخصي', 60.w, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile()),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(right: 5.w),
                  child: Text(
                    "نبذة عني",
                    style: TextStyle(
                        color: const Color(0xff2FA09C), fontSize: 14.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5.w, left: 5.w, top: 1.h),
                  child: ReadMoreText(
                    "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص كاملاً،دور مولد النص العربى أن يوفر على المصمم عناء مولد النص العربى أن يوفر على المصمم عناء البحث عن نص بديل .",
                    trimLines: 3,
                    colorClickableText: Colors.pink,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'اقرا المزيد',
                    trimExpandedText: 'اخفاء',
                    style: TextStyle(color: Colors.black, fontSize: 13.sp),
                    moreStyle: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff2FA09C)),
                    lessStyle: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff2FA09C)),
                  ),
                ),
                // SizedBox(
                //   height: 60.h,
                //   child:
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.count(
                      mainAxisSpacing: 5, //horizontal space
                      crossAxisSpacing: 5, //vertical space
                      crossAxisCount: 3,
                      childAspectRatio: (12 / 10),
                      controller: ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: imgs.map((value) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StroyDetails()),
                            );
                          },
                          child: Image.asset(
                            value,
                            fit: BoxFit.fill,
                            // height: 50,
                          ),
                        );
                      }).toList()),
                ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
