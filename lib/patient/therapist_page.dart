import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/controllers/sp_helper.dart';
import 'package:heelingtouchproject/therapist/auth/edit_profile.dart';
import 'package:heelingtouchproject/therapist/notifications_screen.dart';
import 'package:heelingtouchproject/therapist/story_details.dart';
import 'package:heelingtouchproject/widgets/app_button.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

import 'consultaion_request_page.dart';

class TherapistDetails extends StatefulWidget {
  const TherapistDetails({Key? key}) : super(key: key);

  @override
  State<TherapistDetails> createState() => _TherapistDetailsState();
}

class _TherapistDetailsState extends State<TherapistDetails> {
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
          title: Text('',
              style: TextStyle(color: const Color(0xffffffff), fontSize: 13.sp),
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
              icon: Image.asset("assets/Notification.png"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
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
                        decoration: BoxDecoration(
                            color: const Color(0xff2FA09C),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(SpHelper.spHelper
                                          .getTherapisImg() ==
                                      ""
                                  ? "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-Vector-PNG-Clipart.png"
                                  : SpHelper.spHelper.getTherapisImg()),
                            ))),
                    SizedBox(
                      width: 2.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${SpHelper.spHelper.getTherapisFname()} ${SpHelper.spHelper.getTherapisIDLname()}",
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
                          SpHelper.spHelper.getTherapisPhoneNumber(),
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
                        App_Button3('احجز موعد الآن', 60.w, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ConsultationRequest()),
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
                    "نبذة عن الطبيب",
                    style: TextStyle(
                        color: const Color(0xff2FA09C), fontSize: 14.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5.w, left: 5.w, top: 1.h),
                  alignment: Alignment.topRight,
                  child: ReadMoreText(
                    SpHelper.spHelper.getTherapisBio() == ""
                        ? "لم تتم اضافة نبذة بعد"
                        : SpHelper.spHelper.getTherapisBio(),
                    trimLines: 3,
                    colorClickableText: Colors.pink,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'اقرا المزيد',
                    trimExpandedText: 'اخفاء',
                    textAlign: TextAlign.start,
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
                                  builder: (context) => const StroyDetails()),
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
