import 'package:flutter/material.dart';
import 'package:heelingtouchproject/controllers/sp_helper.dart';
import 'package:heelingtouchproject/therapist/chat_details.dart';
import 'package:sizer/sizer.dart';

// ignore: camel_case_types, must_be_immutable
class messegeItem extends StatelessWidget {
  String id;
  String name;
  String lastMessege;
  String therapistID;
  String patientID;
  String day;
  String img;
  String phone;
  messegeItem(this.id, this.name, this.phone, this.lastMessege,
      this.therapistID, this.patientID, this.day, this.img,
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
            SpHelper.spHelper.setTherapistID(therapistID);
            SpHelper.spHelper.setTherapistFname(name);
            SpHelper.spHelper.setPatientID(patientID);
            SpHelper.spHelper.setTimeID(day);
            SpHelper.spHelper.setPhone(phone);
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
                                fit: BoxFit.fill,
                                image: img == ""
                                    ? const NetworkImage(
                                        "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-Vector-PNG-Clipart.png")
                                    : NetworkImage(img)))),
                    SizedBox(
                      width: 2.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(fontFamily: 'NeoSansArabic'),
                        ),
                        Text(
                          lastMessege,
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
                    "$day:00",
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
