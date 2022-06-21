import 'package:flutter/material.dart';
import 'package:heelingtouchproject/therapist/chat_details.dart';
import 'package:sizer/sizer.dart';

// ignore: camel_case_types, must_be_immutable
class messegeItem extends StatelessWidget {
  String id;
  String name;
  String lastMessege;
  String day;
  // String img;
  messegeItem(this.id, this.name, this.lastMessege, this.day, {Key? key})
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
                        decoration: const BoxDecoration(
                            color: Color(0xff2FA09C),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                  "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-Vector-PNG-Clipart.png"),
                            ))),
                    SizedBox(
                      width: 2.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name),
                        Text(
                          lastMessege,
                          style: const TextStyle(color: Colors.grey),
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
                    style: const TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
