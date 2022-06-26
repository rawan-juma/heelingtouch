import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/controllers/firebase_helper.dart';
import 'package:heelingtouchproject/controllers/sp_helper.dart';
import 'package:heelingtouchproject/model/chat.dart';
import 'package:heelingtouchproject/model/consultations.dart';
import 'package:heelingtouchproject/therapist/chat_screen.dart';
import 'package:heelingtouchproject/widgets/app_button.dart';
import 'package:heelingtouchproject/widgets/thirapst2_item.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import '../controllers/app_provider.dart';

class ConsultationRequest extends StatefulWidget {
  const ConsultationRequest({Key? key}) : super(key: key);

  @override
  State<ConsultationRequest> createState() => _ConsultationRequestState();
}

class _ConsultationRequestState extends State<ConsultationRequest> {
  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;
  int _selectedDay = DateTime.now().day;
  int _selectedHour = DateTime.now().hour;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text('حجز استشارة',
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
            body: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Therapist2Item(
                      SpHelper.spHelper.getTherapisID(),
                      SpHelper.spHelper.getTherapisFname(),
                      // SpHelper.spHelper.getTherapisIDLname(),
                      SpHelper.spHelper.getTherapisPhoneNumber(),
                      SpHelper.spHelper.getTherapisBio(),
                      SpHelper.spHelper.getTherapisImg()),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 5.h, bottom: 2.h),
                    child: Text(
                      "نوع الاستشارة سيكون كالتالي:",
                      style: TextStyle(
                          fontFamily: 'NeoSansArabic',
                          color: const Color(0xff2FA09C),
                          fontSize: 13.sp),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/calll.png",
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Image.asset("assets/chatl.png")
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2.h, right: 8.0, left: 8.0),
                    height: 12.h,
                    child: DatePicker(
                      DateTime.now(),
                      locale: "ar_SA",
                      dateTextStyle: TextStyle(
                          fontFamily: 'NeoSansArabic',
                          color: const Color.fromARGB(255, 61, 61, 61),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold),
                      monthTextStyle: TextStyle(
                          fontFamily: 'NeoSansArabic',
                          color: const Color(0xff2FA09C),
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold),
                      dayTextStyle: TextStyle(
                          fontFamily: 'NeoSansArabic',
                          color: const Color(0xff2FA09C),
                          fontWeight: FontWeight.bold,
                          fontSize: 8.sp),
                      initialSelectedDate: DateTime.now(),
                      selectionColor: const Color(0xff2FA09C),
                      selectedTextColor: Colors.white,
                      onDateChange: (date) {
                        // New date selected
                        setState(() {
                          _selectedYear = date.year;
                          _selectedMonth = date.month;
                          _selectedDay = date.day;
                          // _selectedHour = DateTime.now().hour;
                          log(_selectedYear.toString());
                          log(_selectedMonth.toString());
                          log(_selectedDay.toString());
                          log(_selectedHour.toString());
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2.h, right: 8.0, left: 8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _selectedHour = 8;
                              log(_selectedHour.toString());
                            },
                            child: Container(
                              // margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                          10.0) //                 <--- border radius here
                                      ),
                                  border: Border.all(
                                      color: const Color(0xff2FA09C))),
                              child: const Text('8:00am'),
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectedHour = 9;
                              log(_selectedHour.toString());
                            },
                            child: Container(
                              // margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                          10.0) //                 <--- border radius here
                                      ),
                                  border: Border.all(
                                      color: const Color(0xff2FA09C))),
                              child: const Text('9:00am'),
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectedHour = 10;
                              log(_selectedHour.toString());
                            },
                            child: Container(
                              // margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                          10.0) //                 <--- border radius here
                                      ),
                                  border: Border.all(
                                      color: const Color(0xff2FA09C))),
                              child: const Text('10:00am'),
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectedHour = 11;
                              log(_selectedHour.toString());
                            },
                            child: Container(
                              // margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                          10.0) //                 <--- border radius here
                                      ),
                                  border: Border.all(
                                      color: const Color(0xff2FA09C))),
                              child: const Text('11:00am'),
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectedHour = 12;
                              log(_selectedHour.toString());
                            },
                            child: Container(
                              // margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                          10.0) //                 <--- border radius here
                                      ),
                                  border: Border.all(
                                      color: const Color(0xff2FA09C))),
                              child: const Text('12:00pm'),
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectedHour = 1;
                              log(_selectedHour.toString());
                            },
                            child: Container(
                              // margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                          10.0) //                 <--- border radius here
                                      ),
                                  border: Border.all(
                                      color: const Color(0xff2FA09C))),
                              child: const Text('1:00pm'),
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectedHour = 2;
                              log(_selectedHour.toString());
                            },
                            child: Container(
                              // margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                          10.0) //                 <--- border radius here
                                      ),
                                  border: Border.all(
                                      color: const Color(0xff2FA09C))),
                              child: const Text('2:00pm'),
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectedHour = 3;
                              log(_selectedHour.toString());
                            },
                            child: Container(
                              // margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                          10.0) //                 <--- border radius here
                                      ),
                                  border: Border.all(
                                      color: const Color(0xff2FA09C))),
                              child: const Text('3:00pm'),
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectedHour = 4;
                              log(_selectedHour.toString());
                            },
                            child: Container(
                              // margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                          10.0) //                 <--- border radius here
                                      ),
                                  border: Border.all(
                                      color: const Color(0xff2FA09C))),
                              child: const Text('4:00pm'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25.h),
                    alignment: Alignment.bottomCenter,
                    child: App_Button("تأكيد الحجز", 90.w, () async {
                      List<Consultaion> cons = await FirestoreHelper
                          .firestoreHelper
                          .patientConsultaions();
                      if (cons.length < 3) {
                        appProvider.createChatRoom(
                            appProvider.username.toString(),
                            SpHelper.spHelper.getTherapisFname(),
                            appProvider.img.toString(),
                            SpHelper.spHelper.getTherapisImg(),
                            _selectedHour,
                            SpHelper.spHelper.getTherapisID(),
                            "test test test",
                            appProvider.phone.toString());
                        appProvider.addConsultaion(
                            SpHelper.spHelper.getTherapisID(),
                            _selectedYear,
                            _selectedMonth,
                            _selectedDay,
                            _selectedHour);
                      } else {
                        log("Alert message");
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "إستشارة",
                                  style: TextStyle(
                                      fontFamily: 'NeoSansArabic',
                                      color: const Color(0xff2FA09C),
                                      fontSize: 13.sp),
                                  textAlign: TextAlign.right,
                                ),
                                content: Text(
                                  "لقد قمت باستهلاك جميع التذاكر, قم بشراء المزيد",
                                  style: TextStyle(
                                      fontFamily: 'NeoSansArabic',
                                      color: const Color(0xff000000),
                                      fontSize: 11.sp),
                                  textAlign: TextAlign.right,
                                ),
                              );
                            });
                      }
                    }),
                  )
                ],
              ),
            ),
          ));
    });
  }
}
