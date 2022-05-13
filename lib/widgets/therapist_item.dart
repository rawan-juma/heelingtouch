// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class TherapistItem extends StatelessWidget {
  late String fName;
  late String lName;
  late String img;
  TherapistItem(this.fName, this.lName, this.img, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 4.w),
      child: SizedBox(
        height: 50.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  color: const Color.fromARGB(255, 230, 230, 230),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(img),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: Text(
                "${fName} ${lName}",
                style: TextStyle(fontSize: 13.sp),
              ),
            )
          ],
        ),
      ),
    );
  }
}
