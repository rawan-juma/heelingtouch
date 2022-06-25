// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heelingtouchproject/controllers/auth_helper.dart';
import 'package:heelingtouchproject/controllers/firebase_helper.dart';
import 'package:heelingtouchproject/model/story.dart';
import 'package:heelingtouchproject/model/therapist.dart';
import 'package:heelingtouchproject/therapist/auth/edit_profile.dart';
import 'package:heelingtouchproject/therapist/notifications_screen.dart';
import 'package:heelingtouchproject/therapist/settings.dart';
import 'package:heelingtouchproject/therapist/story_details.dart';
import 'package:heelingtouchproject/widgets/app_button.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/app_provider.dart';
import '../../controllers/sp_helper.dart';

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
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      // return FutureBuilder<Therapist>(
      //   future: FirestoreHelper.firestoreHelper.getTherapist(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text('بروفايلي',
                  style: TextStyle(
                      fontFamily: 'NeoSansArabic',
                      color: const Color(0xffffffff),
                      fontSize: 13.sp),
                  textAlign: TextAlign.center),
              backgroundColor: Color(0xff2FA09C),
              // elevation: 2,
              shadowColor: Colors.grey[100],
              automaticallyImplyLeading: false,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),

              actions: [
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
            body: FutureBuilder<Therapist>(
              future: FirestoreHelper.firestoreHelper.getTherapist(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Directionality(
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
                                  decoration: BoxDecoration(
                                      color: Color(0xff2FA09C),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: snapshot.data!.img == null
                                            ? const NetworkImage(
                                                "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-Vector-PNG-Clipart.png",
                                              )
                                            : NetworkImage(snapshot.data!.img),
                                      ))),
                              SizedBox(
                                width: 2.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data!.fName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: 'NeoSansArabic',
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    snapshot.data!.phonenumber,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: 'NeoSansArabic',
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  App_Button3('تعديل الملف الشخصي', 60.w, () {
                                    // log(appProvider
                                    //     .therpistStoriesList1[0].imgs);
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
                                  fontFamily: 'NeoSansArabic',
                                  color: const Color(0xff2FA09C),
                                  fontSize: 12.sp),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.only(
                                right: 5.w, left: 5.w, top: 1.h),
                            child: ReadMoreText(
                              snapshot.data?.bio ?? "لم تتم اضافة نبذة بعد",
                              trimLines: 3,
                              colorClickableText: Colors.pink,
                              trimMode: TrimMode.Line,
                              textAlign: TextAlign.right,
                              trimCollapsedText: 'اقرا المزيد',
                              trimExpandedText: 'اخفاء',
                              style: TextStyle(
                                  fontFamily: 'NeoSansArabic',
                                  color: Colors.black,
                                  fontSize: 11.sp),
                              moreStyle: TextStyle(
                                  fontFamily: 'NeoSansArabic',
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff2FA09C)),
                              lessStyle: TextStyle(
                                  fontFamily: 'NeoSansArabic',
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff2FA09C)),
                            ),
                          ),
                          // SizedBox(
                          //   height: 60.h,
                          //   child:
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:
                                  //  FutureBuilder<List<dynamic>>(
                                  //   future: appProvider.fetchTherpistStories1(),
                                  //   builder: (context, snapshot) {
                                  // return
                                  appProvider.therpistStoriesList1.isNotEmpty
                                      ? GridView.count(
                                          mainAxisSpacing: 5, //horizontal space
                                          crossAxisSpacing: 5, //vertical space
                                          crossAxisCount: 3,
                                          childAspectRatio: (12 / 10),
                                          controller: ScrollController(
                                              keepScrollOffset: false),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          children: appProvider
                                              .therpistStoriesList1
                                              .map((value) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const StroyDetails()),
                                                );
                                                SpHelper.spHelper
                                                    .setStoryDescription(
                                                        value.description);
                                                SpHelper.spHelper
                                                    .setStoryImg(value.imgs);
                                              },
                                              child: Image.network(
                                                value.imgs,
                                                fit: BoxFit.fill,
                                                // height: 50,
                                              ),
                                            );
                                          }).toList())
                                      //   },
                                      // ),
                                      : Text("لا يوجد اي قصص نجاح",
                                          style: TextStyle(
                                              fontFamily: 'NeoSansArabic',
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xff2FA09C)))),
                        ],
                      ),
                    ),
                  );
                } else {
                  Center(child: CircularProgressIndicator());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ));
    });
  }
}
