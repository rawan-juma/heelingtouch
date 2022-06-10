import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/controllers/sp_helper.dart';
import 'package:heelingtouchproject/model/messege.dart';
import 'package:heelingtouchproject/widgets/app_button.dart';
import 'package:heelingtouchproject/widgets/thirapst2_item.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../controllers/app_provider.dart';

class ConsultationRequest extends StatelessWidget {
  const ConsultationRequest({Key? key}) : super(key: key);

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
                icon: Image.asset("assets/Arrow - Right 2.png"),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),
            ),
            body: Column(
              children: [
                Therapist2Item(
                    SpHelper.spHelper.getTherapisID(),
                    SpHelper.spHelper.getTherapisFname(),
                    SpHelper.spHelper.getTherapisIDLname(),
                    SpHelper.spHelper.getTherapisPhoneNumber(),
                    SpHelper.spHelper.getTherapisBio(),
                    SpHelper.spHelper.getTherapisImg()),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 5.h),
                  child: Text(
                    "نوع الاستشارة",
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
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    '03:00 am',
                    style: TextStyle(
                      fontFamily: 'NeoSansArabic',
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                App_Button("تأكيد الحجز", 90.w, () {
                  appProvider.createChatRoom("3:00",
                      SpHelper.spHelper.getTherapisID(), "test test test");
                  appProvider.addConsultaion(SpHelper.spHelper.getTherapisID());
                })
              ],
            ),
          ));
    });
  }
}
