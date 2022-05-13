import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class ChatDetails extends StatelessWidget {
  const ChatDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          // title: Text('الرسائل',
          //     style: TextStyle(color: const Color(0xff000000), fontSize: 15.sp),
          //     textAlign: TextAlign.center),
          backgroundColor: const Color(0xff2FA09C),
          // elevation: 2,
          shadowColor: Colors.grey[100],
          systemOverlayStyle: SystemUiOverlayStyle.light,
          leading: IconButton(
            icon: Image.asset("assets/Iconly-Light-Call.png"),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Search()),
              // );
            },
          ),
          actions: [
            Center(
              child: Text(
                "مريم سعيد",
                style: TextStyle(color: Colors.black, fontSize: 13.sp),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Container(
                width: 10.w,
                height: 11.h,
                decoration: const BoxDecoration(
                    color: Color(0xff2FA09C),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/personP.png"),
                    ))),
            IconButton(
              icon: Image.asset("assets/Arrow - Right 2.png"),
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
            ),
          ],
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BubbleNormal(
                      text: 'السلام عليكم',
                      isSender: false,
                      color: const Color(0xFFDFDFDF),
                      tail: false,
                      textStyle: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                    BubbleNormal(
                      text: 'وعليكم السلام',
                      textStyle: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                      color: const Color(0xFF2FA09C),
                      tail: false,
                      sent: true,
                      seen: true,
                      delivered: true,
                    ),
                  ],
                ),

                // Padding(
                //   padding: EdgeInsets.only(left: 3.w, right: 3.w),
                // child:
                Row(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/sendBtn.png'),
                      iconSize: 55.0,
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 6.h,
                      width: 80.w,
                      child: const TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          // hintText: '1',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  // ),
                )
              ],
            ),
          ),
        ));
  }
}
