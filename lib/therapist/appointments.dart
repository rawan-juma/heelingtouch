import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/model/appoitment.dart';
import 'package:heelingtouchproject/widgets/appointments_item.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class MyAppointments extends StatelessWidget {
  MyAppointments({Key? key}) : super(key: key);
  List<Appointment> appoitmentsList = [
    Appointment("0", "10:00am", "10:00am"),
    Appointment("0", "10:00am", "10:00am"),
    Appointment("0", "10:00am", "10:00am"),
    Appointment("0", "10:00am", "10:00am"),
    Appointment("0", "10:00am", "10:00am"),
    Appointment("0", "10:00am", "10:00am"),
    Appointment("0", "10:00am", "10:00am"),
    Appointment("0", "10:00am", "10:00am"),
    Appointment("0", "10:00am", "10:00am"),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text('مواعيدي',
              style: TextStyle(color: const Color(0xffffffff), fontSize: 13.sp),
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
        body: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: appoitmentsList.map((e) {
              return AppointmentItem(
                e.id,
                e.preTime,
                e.postTime,
              );
            }).toList()),
      ),
    );
  }
}
