import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/therapist/notifications_screen.dart';
import 'package:heelingtouchproject/widgets/message_item.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../controllers/app_provider.dart';

// ignore: must_be_immutable
class PatientChat extends StatelessWidget {
  // List<Messege> messeges = [
  //   Messege('0', 'assets/personP.png', 'مريم سعيد', 'السلام عليكم', 'الثلاثاء'),
  //   Messege('0', 'assets/personP.png', 'مريم سعيد', 'السلام عليكم', 'الثلاثاء'),
  //   Messege('0', 'assets/personP.png', 'مريم سعيد', 'السلام عليكم', 'الثلاثاء'),
  //   Messege('0', 'assets/personP.png', 'مريم سعيد', 'السلام عليكم', 'الثلاثاء'),
  //   Messege('0', 'assets/personP.png', 'مريم سعيد', 'السلام عليكم', 'الثلاثاء'),
  //   Messege('0', 'assets/personP.png', 'مريم سعيد', 'السلام عليكم', 'الثلاثاء'),
  //   Messege('0', 'assets/personP.png', 'مريم سعيد', 'السلام عليكم', 'الثلاثاء'),
  //   Messege('0', 'assets/personP.png', 'مريم سعيد', 'السلام عليكم', 'الثلاثاء'),
  //   Messege('0', 'assets/personP.png', 'مريم سعيد', 'السلام عليكم', 'الثلاثاء'),
  //   Messege('0', 'assets/personP.png', 'مريم سعيد', 'السلام عليكم', 'الثلاثاء'),
  // ];
  PatientChat({Key? key}) : super(key: key);
  int isFirst = 1;
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text('الرسائل',
                style:
                    TextStyle(color: const Color(0xffffffff), fontSize: 13.sp),
                textAlign: TextAlign.center),
            backgroundColor: const Color(0xff2FA09C),
            // elevation: 2,
            shadowColor: Colors.grey[100],
            systemOverlayStyle: SystemUiOverlayStyle.light,
            leading: IconButton(
              icon: Image.asset("assets/Notification.png"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
            actions: [
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
          body: Padding(
            padding: EdgeInsets.only(left: 3.w, right: 3.w, bottom: 0.h),
            child: isFirst == 0
                ? Center(
                    child: Image.asset("assets/Fchat.png"),
                  )
                : ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: appProvider.chats.map((e) {
                      // appProvider.get
                      return messegeItem(
                        e.id,
                        e.therapistID,
                        e.patientID,
                        e.time,
                        // e.img,
                      );
                    }).toList()),
          ));
    });
  }
}
