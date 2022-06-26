import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/therapist/notifications_screen.dart';
import 'package:heelingtouchproject/widgets/message_item.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../controllers/app_provider.dart';
import '../controllers/firebase_helper.dart';
import '../model/chat.dart';

// ignore: must_be_immutable
class PatientChat extends StatelessWidget {
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
                style: TextStyle(
                    fontFamily: 'NeoSansArabic',
                    color: const Color(0xffffffff),
                    fontSize: 13.sp),
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
                  : FutureBuilder<List<ChatRoom>>(
                      future: FirestoreHelper.firestoreHelper.fetchChats(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              children: snapshot.data!.map((e) {
                                return messegeItem(
                                  e.id,
                                  e.therapistName,
                                  e.messages[e.messages.length - 1]['content'],
                                  e.therapistID,
                                  e.patientID,
                                  e.time.toString(),
                                  e.therapistImg,
                                );
                              }).toList());
                          // }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )));
    });
  }
}
