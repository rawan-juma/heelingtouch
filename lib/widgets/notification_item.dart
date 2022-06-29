import 'package:flutter/material.dart';
import 'package:heelingtouchproject/controllers/sp_helper.dart';
import 'package:heelingtouchproject/therapist/chat_details.dart';
import 'package:sizer/sizer.dart';

// ignore: camel_case_types, must_be_immutable
class NotificationItem extends StatelessWidget {
  String id;
  String title;
  // String subtitle;
  String day;
  String img;
  String username;
  NotificationItem(this.id, this.title, this.day, this.img, this.username,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return Consumer<AppProvider>(builder: (context, appProvider, x) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ChatDetails()));
          },
          child: SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        width: 15.w,
                        height: 13.h,
                        decoration: BoxDecoration(
                            color: const Color(0xff2FA09C),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: img == ""
                                  ? NetworkImage(img)
                                  : NetworkImage(img),
                            ))),
                    SizedBox(
                      width: 2.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontFamily: 'NeoSansArabic'),
                        ),
                        Text(
                          username == SpHelper.spHelper.getTherapisFname()
                              ? "لقد قمت بحجز استشارة لدى $username"
                              : "لقد قام $username بحجز استشارة لديك",
                          style: const TextStyle(
                              fontFamily: 'NeoSansArabic', color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),

                // SizedBox(
                //   width: 40.w,
                // ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Text(
                    day,
                    style: const TextStyle(
                        fontFamily: 'NeoSansArabic', color: Colors.grey),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
