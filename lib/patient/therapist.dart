import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/patient/search_therapist.dart';
import 'package:heelingtouchproject/widgets/thirapst2_item.dart';
import 'package:provider/provider.dart';
import '../controllers/app_provider.dart';
import '../therapist/notifications_screen.dart';
import 'package:sizer/sizer.dart';

class TherapistList extends StatelessWidget {
  const TherapistList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text('الإخصائيين',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchTherapist()),
                  );
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
              height: 100.h,
              child: appProvider.therapistsList.isNotEmpty
                  ? ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: appProvider.therapistsList.map((e) {
                        return Therapist2Item(e.id, e.fName, e.lName,
                            e.phonenumber, e.bio, e.img);
                      }).toList())
                  : const Center(
                      child: CircularProgressIndicator(
                      color: Color(0xff2FA09C),
                    ))),
        ),
      );
    });
  }
}
