import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heelingtouchproject/controllers/sp_helper.dart';
import 'package:heelingtouchproject/therapist/auth/edit_profile.dart';
import 'package:heelingtouchproject/therapist/notifications_screen.dart';
import 'package:heelingtouchproject/therapist/story_details.dart';
import 'package:heelingtouchproject/widgets/app_button.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

import '../controllers/app_provider.dart';
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
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text('',
                style:
                    TextStyle(color: const Color(0xffffffff), fontSize: 13.sp),
                textAlign: TextAlign.center),
            backgroundColor: const Color(0xff2FA09C),
            // elevation: 2,
            shadowColor: Colors.grey[100], automaticallyImplyLeading: false,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
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
                          width: 120,
                          height: 160,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
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
                              fontSize: 13.sp,
                              color: Colors.black,
                              fontFamily: 'NeoSansArabic',
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            SpHelper.spHelper.getTherapisPhoneNumber(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black,
                              fontFamily: 'NeoSansArabic',
                            ),
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
                      SizedBox(
                        width: 4.w,
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(right: 4.w, top: 2.h),
                    child: Text(
                      "نبذة عن الطبيب",
                      style: TextStyle(
                          fontFamily: 'NeoSansArabic',
                          color: const Color(0xff2FA09C),
                          fontSize: 14.sp),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 4.w, left: 4.w, top: 1.h),
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
                      style: TextStyle(
                          fontFamily: 'NeoSansArabic',
                          color: Colors.black,
                          fontSize: 12.sp),
                      moreStyle: TextStyle(
                          fontFamily: 'NeoSansArabic',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff2FA09C)),
                      lessStyle: TextStyle(
                          fontFamily: 'NeoSansArabic',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff2FA09C)),
                    ),
                  ),
                  // SizedBox(
                  //   height: 60.h,
                  //   child:
                  Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: GridView.count(
                        mainAxisSpacing: 5, //horizontal space
                        crossAxisSpacing: 5, //vertical space
                        crossAxisCount: 3,
                        childAspectRatio: (12 / 10),
                        controller: ScrollController(keepScrollOffset: false),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: appProvider.therpistStoriesList.map((value) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const StroyDetails()),
                              );
                              SpHelper.spHelper
                                  .setStoryDescription(value.description);
                              SpHelper.spHelper.setStoryImg(value.imgs);
                            },
                            child: Image.network(
                              value.imgs,
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
    });
  }
}
