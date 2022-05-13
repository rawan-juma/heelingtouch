import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class AppointmentItem extends StatefulWidget {
  String id;
  String preTime;
  String postTime;

  AppointmentItem(this.id, this.preTime, this.postTime, {Key? key})
      : super(key: key);

  @override
  State<AppointmentItem> createState() => _AppointmentItem();
}

class _AppointmentItem extends State<AppointmentItem> {
  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool status = false;
    // return Consumer<AppProvider>(builder: (context, appProvider, x) {
    return GestureDetector(
        onTap: () {},
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                height: 12.h,
                width: 360.w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Card(
                  elevation: 2.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.postTime,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  color: const Color(0xff000000),
                                  fontFamily: 'MULI'),
                            ),
                            Container(
                              height: 2,
                              width: 7,
                              color: Colors.grey,
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                            ),
                            Text(
                              widget.postTime,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  color: const Color(0xff000000),
                                  fontFamily: 'MULI'),
                            ),
                          ],
                        ),
                        FlutterSwitch(
                          width: 40.0,
                          height: 20.0,
                          valueFontSize: 5.0,
                          toggleSize: 20.0,
                          value: true,
                          activeColor: const Color(0xff2FA09C),
                          inactiveColor: const Color(0xffDFDFDF),
                          activeToggleColor: const Color(0xffDFDFDF),
                          inactiveToggleColor: const Color(0xff2FA09C),
                          borderRadius: 10.0,
                          padding: 2.0,
                          showOnOff: status,
                          onToggle: (val) {
                            setState(() {
                              status = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
