import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/patient/patient_profile.dart';
import 'package:heelingtouchproject/widgets/story2_item.dart';
import 'package:provider/provider.dart';

import '../controllers/app_provider.dart';
import '../therapist/chat_screen.dart';
import '../therapist/notifications_screen.dart';
import 'package:sizer/sizer.dart';

class StoriesList extends StatelessWidget {
  const StoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text('قصص النجاح',
                style:
                    TextStyle(color: const Color(0xffffffff), fontSize: 13.sp),
                textAlign: TextAlign.center),
            backgroundColor: const Color(0xff2FA09C),
            // elevation: 2,
            automaticallyImplyLeading: false,
            shadowColor: Colors.grey[100],
            systemOverlayStyle: SystemUiOverlayStyle.light, leadingWidth: 100,

            leading: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Image.asset("assets/Search.png"),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Chat()),
                  // );
                },
              ),
              IconButton(
                icon: Image.asset("assets/Notification.png"),
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
          body: SizedBox(
            height: 25.h,
            child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: appProvider.storiesList.map((e) {
                  return Story2Item(e.id, e.description, e.imgs);
                }).toList()),
          ),
        ),
      );
    });
  }
}
