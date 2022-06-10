import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heelingtouchproject/controllers/app_provider.dart';
import 'package:heelingtouchproject/patient/search_therapist.dart';
import 'package:heelingtouchproject/patient/stories.dart';
import 'package:heelingtouchproject/patient/therapist.dart';
import 'package:heelingtouchproject/therapist/chat_screen.dart';
import 'package:heelingtouchproject/therapist/notifications_screen.dart';
import 'package:heelingtouchproject/widgets/stories_item.dart';
import 'package:heelingtouchproject/widgets/therapist_item.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'patient_profile.dart';

// ignore: must_be_immutable
class PatientHome extends StatelessWidget {
  PatientHome({Key? key}) : super(key: key);
  static const routeName = "/PatientHome";

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text('الرئيسية',
                style: TextStyle(
                    color: const Color(0xffffffff),
                    fontSize: 13.sp,
                    fontFamily: 'NeoSansArabic'),
                textAlign: TextAlign.center),
            backgroundColor: const Color(0xff2FA09C),
            // elevation: 2,
            automaticallyImplyLeading: false,
            shadowColor: Colors.grey[100],
            systemOverlayStyle: SystemUiOverlayStyle.light, leadingWidth: 100,

            leading: Row(
              children: [
                IconButton(
                  icon: SvgPicture.asset("assets/Profile.svg",
                      semanticsLabel: 'profile icon'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PatientProfile()),
                    );
                  },
                ),
                IconButton(
                  icon: SvgPicture.asset("assets/Chat.svg",
                      semanticsLabel: 'chat icon'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Chat()),
                    );
                  },
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: SvgPicture.asset("assets/Search.svg",
                    semanticsLabel: 'search icon'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchTherapist()),
                  );
                },
              ),
              IconButton(
                icon: SvgPicture.asset("assets/Notification.svg",
                    semanticsLabel: 'notification icon'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationScreen()),
                  );
                },
              ),
            ],
          ),
          body: SizedBox(
              child: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w),
                    decoration: BoxDecoration(
                      // color: const Color.fromARGB(0, 124, 124, 124),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ImageSlideshow(
                        width: 92.w,
                        height: 25.h,
                        initialPage: 0,
                        indicatorColor: const Color(0xff2FA09C),
                        indicatorBackgroundColor: Colors.white,
                        onPageChanged: (value) {
                          // debugPrint('Page changed: $value');
                        },
                        autoPlayInterval: 3000,
                        isLoop: true,
                        children: appProvider.adsList.isEmpty
                            ? [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(20), // Image border
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(
                                        48), // Image radius
                                    child: Image.asset(
                                      "assets/story.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              ]
                            : appProvider.adsList.map((e) {
                                return ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(20), // Image border
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(
                                        48), // Image radius
                                    child: Image.network(
                                      e.img,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList()),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.h, left: 4.w, right: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "الاخصائيين",
                          style: TextStyle(
                              fontSize: 13.sp, fontFamily: 'NeoSansArabic'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TherapistList()),
                            );
                          },
                          child: Text(
                            "عرض الكل",
                            style: TextStyle(
                                fontFamily: 'NeoSansArabic',
                                fontSize: 10.sp,
                                color: const Color(0xff2FA09C)),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 22.h,
                    child: ListView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: appProvider.therapistsList.map((e) {
                          return TherapistItem(e.therapistID, e.fName, e.lName,
                              e.phonenumber, e.bio, e.img);
                        }).toList()),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.h, left: 4.w, right: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "قصص نجاح",
                          style: TextStyle(
                              fontFamily: 'NeoSansArabic', fontSize: 13.sp),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const StoriesList()),
                            );
                          },
                          child: Text(
                            "عرض الكل",
                            style: TextStyle(
                                fontFamily: 'NeoSansArabic',
                                fontSize: 10.sp,
                                color: const Color(0xff2FA09C)),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35.h,
                    child: ListView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: appProvider.storiesList.map((e) {
                          log(e.imgs);
                          return StorytItem(e.description, e.imgs);
                        }).toList()),
                  ),
                ],
              ),
            ),
          )),
        ),
      );
    });
  }
}
