import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class Slide extends StatelessWidget {
  String img = '';
  String title = '';
  String subTitle = '';
  Slide(this.img, this.title, this.subTitle, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
              child: Image.asset(
            img,
            width: 150.w,
            height: 45.h,
          )),
          Padding(
            padding: EdgeInsets.only(top: 4.h, right: 4.w),
            child: Text(
              title,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h, right: 4.w, left: 6.w),
            child: Text(
              subTitle,
              style: TextStyle(fontSize: 14.sp),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }
}
