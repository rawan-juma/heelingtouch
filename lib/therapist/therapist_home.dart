import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:heelingtouchproject/controllers/firebase_helper.dart';
import 'package:heelingtouchproject/therapist/auth/profile.dart';
import 'package:heelingtouchproject/therapist/chat_screen.dart';
import 'package:heelingtouchproject/therapist/notifications_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../controllers/app_provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text('مواعيدي',
              style: TextStyle(
                  fontFamily: 'NeoSansArabic',
                  color: const Color(0xffffffff),
                  fontSize: 13.sp),
              textAlign: TextAlign.center),
          backgroundColor: const Color(0xff2FA09C),
          // elevation: 2,
          automaticallyImplyLeading: false,
          shadowColor: Colors.grey[100],
          systemOverlayStyle: SystemUiOverlayStyle.light,
          leading: IconButton(
            icon: Image.asset(
              "assets/Profile.png",
            ),
            onPressed: () {
              appProvider.fetchTherpistStories1();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
          ),
          actions: [
            IconButton(
              icon: Image.asset("assets/Chat.png"),
              onPressed: () {
                appProvider.getChats();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Chat()),
                );
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
        body: const SizedBox(
            child: Directionality(
          textDirection: TextDirection.rtl,
          child: CalendarScreen(),
        )),
      );
    });
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    // return Consumer<AppProvider>(builder: (context, appProvider, x) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            // child: Padding(
            // padding: EdgeInsets.all(2.h),
            child: FutureBuilder<List<NeatCleanCalendarEvent>>(
              future: FirestoreHelper.firestoreHelper
                  .therapistConsultaionsForCalender(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Calendar(
                    startOnMonday: true,
                    weekDays: const [
                      'اثنين',
                      'ثلاثاء',
                      'اربعاء',
                      'خميس',
                      'جمعة',
                      'سبت',
                      'احد'
                    ],
                    bottomBarColor: const Color(0xff2FA09C),
                    bottomBarArrowColor: Colors.white,
                    eventsList: snapshot.data!,
                    isExpandable: true,
                    hideTodayIcon: true,
                    eventDoneColor: Colors.green,
                    selectedColor: const Color(0xff2FA09C),
                    todayColor: Colors.blue,
                    eventColor: null,
                    locale: 'ar',
                    bottomBarTextStyle: const TextStyle(color: Colors.white),
                    // todayButtonText: 'Heute',
                    // allDayEventText: 'Ganztägig',
                    // multiDayEndText: 'Ende',
                    isExpanded: true,
                    expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                    // datePickerType: DatePickerType.date,
                    displayMonthTextStyle: const TextStyle(
                        fontFamily: 'NeoSansArabic',
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 13),
                    dayOfWeekStyle: const TextStyle(
                        fontFamily: 'NeoSansArabic',
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 11),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            // ),
          ),
        ));
    // });
  }

  // void _handleNewDate(date) {
  //   log('Date selected: $date');
  // }
}
