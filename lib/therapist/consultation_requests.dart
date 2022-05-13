import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/model/consultations.dart';
import 'package:heelingtouchproject/therapist/notifications_screen.dart';
import 'package:heelingtouchproject/widgets/consultation_item.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class ConsultationRequests extends StatelessWidget {
  List<Consultaion> consultationRequestsList = [
    Consultaion("0", "مريم سعيد", "assets/personP.png", "10:00 am"),
    Consultaion("0", "مريم سعيد", "assets/personP.png", "10:00 am"),
    Consultaion("0", "مريم سعيد", "assets/personP.png", "10:00 am"),
    Consultaion("0", "مريم سعيد", "assets/personP.png", "10:00 am"),
    Consultaion("0", "مريم سعيد", "assets/personP.png", "10:00 am"),
    Consultaion("0", "مريم سعيد", "assets/personP.png", "10:00 am"),
    Consultaion("0", "مريم سعيد", "assets/personP.png", "10:00 am"),
    Consultaion("0", "مريم سعيد", "assets/personP.png", "10:00 am"),
    Consultaion("0", "مريم سعيد", "assets/personP.png", "10:00 am"),
    Consultaion("0", "مريم سعيد", "assets/personP.png", "10:00 am"),
    Consultaion("0", "مريم سعيد", "assets/personP.png", "10:00 am"),
  ];

  ConsultationRequests({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          title: Text('طلبات الاستشارة',
              style: TextStyle(color: const Color(0xffffffff), fontSize: 13.sp),
              textAlign: TextAlign.center),
          backgroundColor: const Color(0xff2FA09C),
          // elevation: 2,
          shadowColor: Colors.grey[100],
          automaticallyImplyLeading: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          actions: [
            IconButton(
              icon: Image.asset("assets/Notification.png"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
          ]),
      body: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: consultationRequestsList.map((e) {
            return ConsultationItem(
              e.id,
              e.name,
              e.image,
              e.time,
            );
          }).toList()),
    );
  }
}
