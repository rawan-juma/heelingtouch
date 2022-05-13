import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:heelingtouchproject/controllers/app_provider.dart';
import 'package:heelingtouchproject/therapist/chat_screen.dart';
import 'package:heelingtouchproject/model/therapist.dart';
import 'package:heelingtouchproject/therapist/notifications_screen.dart';
import 'package:heelingtouchproject/widgets/stories_item.dart';
import 'package:heelingtouchproject/widgets/therapist_item.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'patient_profile.dart';

// ignore: must_be_immutable
class PatientHome extends StatelessWidget {
  PatientHome({Key? key}) : super(key: key);
  static const routeName = "/PatientHome";

  List<Therapist> therapistsList = [
    Therapist(
        id: "0",
        fName: "د.علياء",
        lName: "القيشاوي",
        image: "assets/therapist.png"),
    Therapist(
        id: "0",
        fName: "د.علياء",
        lName: "القيشاوي",
        image: "assets/therapist.png"),
    Therapist(
        id: "0",
        fName: "د.علياء",
        lName: "القيشاوي",
        image: "assets/therapist.png"),
  ];
  List<Therapist> therapistsList1 = [
    // Therapist(id: "0", fname: "د.علياء القيشاوي", image: "assets/story1.png"),
    // Therapist(id: "1", fname: "د.علياء القيشاوي", image: "assets/story1.png"),
    // Therapist(id: "2", fname: "د.علياء القيشاوي", image: "assets/story1.png"),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text('الرئيسية',
              style: TextStyle(color: const Color(0xffffffff), fontSize: 13.sp),
              textAlign: TextAlign.center),
          backgroundColor: const Color(0xff2FA09C),
          // elevation: 2,
          automaticallyImplyLeading: false,
          shadowColor: Colors.grey[100],
          systemOverlayStyle: SystemUiOverlayStyle.light, leadingWidth: 100,

          leading: Row(
            children: [
              IconButton(
                icon: Image.asset(
                  "assets/Profile.png",
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PatientProfile()),
                  );
                },
              ),
              IconButton(
                icon: Image.asset(
                  "assets/Chat.png",
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Chat()),
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
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
          ],
        ),
        body: SizedBox(
            child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 2.h,
                  ),
                  color: Colors.transparent,
                  child: ImageSlideshow(
                    width: double.infinity,
                    height: 200,
                    initialPage: 0,
                    indicatorColor: Colors.blue,
                    indicatorBackgroundColor: Colors.grey,
                    onPageChanged: (value) {
                      // debugPrint('Page changed: $value');
                    },
                    autoPlayInterval: 3000,
                    isLoop: true,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20), // Image border
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(48), // Image radius
                          child: Image.asset(
                            'assets/story.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20), // Image border
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(48), // Image radius
                          child: Image.asset(
                            'assets/story.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20), // Image border
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(48), // Image radius
                          child: Image.asset(
                            'assets/story.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.h, left: 4.w, right: 4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "الاخصائيين",
                        style: TextStyle(fontSize: 13.sp),
                      ),
                      Text(
                        "عرض الكل",
                        style: TextStyle(
                            fontSize: 11.sp, color: const Color(0xff2FA09C)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 25.h,
                  child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: appProvider.therapistsList.map((e) {
                        return TherapistItem(e.fName, e.lName, e.image);
                      }).toList()),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.h, left: 4.w, right: 4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "قصص نجاح",
                        style: TextStyle(fontSize: 13.sp),
                      ),
                      Text(
                        "عرض الكل",
                        style: TextStyle(
                            fontSize: 11.sp, color: const Color(0xff2FA09C)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 35.h,
                  child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: appProvider.storiesList.map((e) {
                        return StorytItem(e.imgs);
                      }).toList()),
                ),
              ],
            ),
          ),
        )),
      );
    });
  }
}
