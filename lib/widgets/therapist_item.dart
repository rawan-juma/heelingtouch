// ignore_for_file: unnecessary_brace_in_string_interps
import 'package:flutter/material.dart';
import 'package:heelingtouchproject/controllers/sp_helper.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../controllers/app_provider.dart';
import '../patient/therapist_page.dart';

// ignore: must_be_immutable
class TherapistItem extends StatelessWidget {
  late String id;
  late String fName;
  late String lName;
  late String phone;
  late String bio;
  late String img;
  TherapistItem(this.id, this.fName, this.lName, this.phone, this.bio, this.img,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TherapistDetails()));
          SpHelper.spHelper.setTherapistID(id);
          SpHelper.spHelper.setTherapistFname(fName);
          SpHelper.spHelper.setTherapistLname(lName);
          SpHelper.spHelper.setTherapistBio(bio);
          SpHelper.spHelper.setTherapistImg(img);
          SpHelper.spHelper.setTherapistPhoneNumber(phone);

          // appProvider.getTherapist(id);
        },
        child: Padding(
          padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 4.w),
          child: SizedBox(
            height: 50.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 15.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 209, 209, 209)
                              .withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      color: const Color(0xff2FA09C),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(img == ""
                            ? "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-Vector-PNG-Clipart.png"
                            : img),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text(
                    "د.$fName $lName",
                    style: TextStyle(fontSize: 13.sp),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
