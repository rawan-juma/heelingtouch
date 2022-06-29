// ignore_for_file: deprecated_member_use
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/controllers/app_provider.dart';
import 'package:heelingtouchproject/controllers/firebase_helper.dart';
import 'package:heelingtouchproject/therapist/notifications_screen.dart';
import 'package:heelingtouchproject/widgets/app_button.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// ignore: must_be_immutable
class AddStoryScreen extends StatelessWidget {
  AddStoryScreen({Key? key}) : super(key: key);
  int isFirst = 1;
  final List<String> imgList = [
    'assets/story.png',
    'assets/story.png',
    'assets/story.png'
  ];
  bool isRequested = false;
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _onLoading() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                Text("Loading"),
              ],
            ),
          );
        },
      );
    }

    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              centerTitle: true,
              title: Text('إضافة قصة نجاح',
                  style: TextStyle(
                      fontFamily: 'NeoSansArabic',
                      color: const Color(0xffffffff),
                      fontSize: 13.sp),
                  textAlign: TextAlign.center),
              backgroundColor: const Color(0xff2FA09C),
              // elevation: 2,
              automaticallyImplyLeading: false,
              shadowColor: Colors.grey[100],
              systemOverlayStyle: SystemUiOverlayStyle.light,
              actions: [
                IconButton(
                  icon: Image.asset("assets/Notification.png"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationScreen()),
                    );
                  },
                ),
              ]),
          body: SizedBox(
              child: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Container(
                        width: 90.w,
                        height: 170,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    FirestoreHelper.firestoreHelper.imageUrl !=
                                            ""
                                        ? NetworkImage(FirestoreHelper
                                            .firestoreHelper.imageUrl)
                                        : const AssetImage('assets/default.png')
                                            as ImageProvider)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 90.w,
                    height: 8.h,
                    child: FlatButton(
                      onPressed: () {
                        FirestoreHelper.firestoreHelper.uploadImage();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.camera_alt,
                            color: Color(0xff2FA09C),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text('إضافة صورة',
                              style: TextStyle(
                                  fontFamily: 'NeoSansArabic',
                                  color: const Color(0xff2FA09C),
                                  fontSize: 13.sp)),
                        ],
                      ),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Color(0xff2FA09C),
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(right: 5.w, top: 2.h),
                    child: Text(
                      "الوصف",
                      style: TextStyle(
                          fontFamily: 'NeoSansArabic',
                          color: const Color(0xff2FA09C),
                          fontSize: 12.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.w, left: 5.w),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: appProvider.storyDescriptionController,
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "اسال شيئا",
                        hintStyle: TextStyle(
                            fontFamily: 'NeoSansArabic',
                            fontSize: 10.sp,
                            color: const Color(0xff000000)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h, bottom: 15.h),
                    child: App_Button('نشر', 90.w, () {
                      appProvider.addStory();
                      // if (FirestoreHelper.firestoreHelper.imageUrl == "") {
                      //   // _onLoading();
                      //   log("Not Added Yet");
                      // } else {
                      //   log("Added Successfully");
                      // }
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const Home()),
                      // );
                    }),
                  ),
                ],
              ),
            ),
          )));
    });
  }
}
