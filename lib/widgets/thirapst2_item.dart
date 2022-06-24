import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:heelingtouchproject/patient/therapist_page.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../controllers/app_provider.dart';
import '../controllers/sp_helper.dart';

// ignore: must_be_immutable
class Therapist2Item extends StatelessWidget {
  String id;
  String fName;
  // String lName;
  String phone;
  String bio;
  // String time;
  String img;
  Therapist2Item(
      this.id,
      this.fName,
      // this.lName,
      this.phone,
      this.bio,
      // this.time,
      this.img,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TherapistDetails()));
              SpHelper.spHelper.setTherapistID(id);
              SpHelper.spHelper.setTherapistFname(fName);
              // SpHelper.spHelper.setTherapistLname(lName);
              SpHelper.spHelper.setTherapistBio(bio);
              SpHelper.spHelper.setTherapistImg(img);
              SpHelper.spHelper.setTherapistPhoneNumber(phone);
              appProvider.fetchTherpistStories(id);
              log(id);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 17.h,
                child: Card(
                  elevation: 2.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 15.h,
                              width: 28.w,
                              decoration: BoxDecoration(
                                  color: const Color(0xff2FA09C),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(img == ""
                                        ? "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-Vector-PNG-Clipart.png"
                                        : img),
                                  )),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            SizedBox(
                              height: 13.h,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "د.$fName",
                                    style: TextStyle(
                                        fontFamily: 'NeoSansArabic',
                                        fontSize: 12.sp,
                                        color: const Color(0xff2FA09C),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Visibility(
                                    visible: true,
                                    child: SizedBox(
                                      width: 58.w,
                                      child: const Text(
                                        "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق",
                                        style: TextStyle(
                                          height: 1.3,
                                          fontFamily: 'NeoSansArabic',
                                          color: Color(0xff1D1D1D),
                                        ),
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Image(
                                        width: 16,
                                        height: 16,
                                        image: Svg('assets/time.svg'),
                                      ),
                                      SizedBox(width: 1.w),
                                      // IconButton(
                                      // SvgPicture.asset(
                                      //   "assets/time.svg",
                                      // ),
                                      //   onPressed: () {},
                                      // ),
                                      const Text(
                                        "09:00am - 03:00pm",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontFamily: 'NeoSansArabic',
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // SizedBox(
                        //   width: 40.w,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      );
    });
  }
}
