import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/model/notifications.dart';
import 'package:heelingtouchproject/widgets/notification_item.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class NotificationScreen extends StatelessWidget {
  List<Notifications> notification = [
    Notifications('0', 'assets/notificationImg.png', 'استشارة',
        'يوجد لديك موعد استشارة بعد 25د', '4د'),
    Notifications('0', 'assets/notificationImg.png', 'استشارة',
        'يوجد لديك موعد استشارة بعد 25د', '4د'),
    Notifications('0', 'assets/notificationImg.png', 'استشارة',
        'يوجد لديك موعد استشارة بعد 25د', '4د'),
    Notifications('0', 'assets/notificationImg.png', 'استشارة',
        'يوجد لديك موعد استشارة بعد 25د', '4د'),
    Notifications('0', 'assets/notificationImg.png', 'استشارة',
        'يوجد لديك موعد استشارة بعد 25د', '4د'),
    Notifications('0', 'assets/notificationImg.png', 'استشارة',
        'يوجد لديك موعد استشارة بعد 25د', '4د'),
    Notifications('0', 'assets/notificationImg.png', 'استشارة',
        'يوجد لديك موعد استشارة بعد 25د', '4د'),
    Notifications('0', 'assets/notificationImg.png', 'استشارة',
        'يوجد لديك موعد استشارة بعد 25د', '4د'),
  ];
  NotificationScreen({Key? key}) : super(key: key);
  int isFirst = 1;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text('الإشعارات',
                style:
                    TextStyle(color: const Color(0xffffffff), fontSize: 13.sp),
                textAlign: TextAlign.center),
            backgroundColor: const Color(0xff2FA09C),
            // elevation: 2,
            shadowColor: Colors.grey[100],
            systemOverlayStyle: SystemUiOverlayStyle.light,
            leading: IconButton(
              icon: Image.asset("assets/Arrow - Right 2.png"),
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
                : ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: notification.map((e) {
                      return NotificationItem(
                        e.id,
                        e.title,
                        e.subTitle,
                        e.dateTime,
                        e.img,
                      );
                    }).toList()),
          )),
    );
  }
}
