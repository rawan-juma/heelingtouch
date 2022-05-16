import 'package:flutter/material.dart';
import 'package:heelingtouchproject/patient/therapist_page.dart';
import 'package:heelingtouchproject/therapist/chat_details.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

// ignore: must_be_immutable
class Therapist2Item extends StatelessWidget {
  String id;
  String fName;
  String lName;
  // String bio;
  // String time;
  String img;
  Therapist2Item(
      this.id,
      this.fName,
      this.lName,
      //  this.bio, this.time,
      this.img,
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
                MaterialPageRoute(builder: (context) => TherapistDetails()));
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
                                color: const Color.fromARGB(255, 230, 230, 230),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(img),
                                )),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "د.$fName $lName",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: const Color(0xff2FA09C),
                                    fontWeight: FontWeight.bold),
                              ),
                              Visibility(
                                visible: true,
                                child: SizedBox(
                                  width: 60.w,
                                  child: const Text(
                                    "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق",
                                    style: TextStyle(
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
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
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
  }
}
