import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/controllers/auth_helper.dart';
import 'package:heelingtouchproject/controllers/firebase_helper.dart';
import 'package:heelingtouchproject/controllers/sp_helper.dart';
import 'package:heelingtouchproject/model/notification.dart';
import 'package:heelingtouchproject/widgets/notification_item.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../controllers/app_provider.dart';

// ignore: must_be_immutable
class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);
  int isFirst = 1;
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text('الإشعارات',
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
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(left: 3.w, right: 3.w, bottom: 0.h),
              child: isFirst == 0
                  ? Center(
                      child: Image.asset("assets/Fchat.png"),
                    )
                  : FutureBuilder<List<Notifications>>(
                      future:
                          FirestoreHelper.firestoreHelper.fetchNotifications(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              children: snapshot.data!.map((e) {
                                if (SpHelper.spHelper.getTherapisID() ==
                                    AuthHelper.authHelper.firebaseAuth
                                        .currentUser!.uid) {
                                  return NotificationItem(
                                      e.id,
                                      "إستشارة",
                                      // e.content,
                                      e.day.toString(),
                                      e.therapistImage.toString(),
                                      e.therapistName);
                                } else {
                                  return NotificationItem(
                                      e.id,
                                      "إستشارة",
                                      // e.content,
                                      e.day.toString(),
                                      e.patientImage.toString(),
                                      e.patientName);
                                }
                              }).toList());
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
            )),
      );
    });
  }
}
