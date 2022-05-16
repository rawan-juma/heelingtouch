import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class StorytItem extends StatelessWidget {
  String img;
  StorytItem(this.img, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 4.w),
      child: SizedBox(
        height: 15.h,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
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
              // child: Image.network(
              //   img,
              //   fit: BoxFit.fill,
              //   height: 15.h,
              //   width: 30.w,
              // ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(right: 5.w),
            //   child: Text(
            //     name,
            //     style: TextStyle(fontSize: 13.sp),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

//     return Padding(
      // padding: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w),
//       child:
//           //  Image.network(
//           //   img,
//           //   fit: BoxFit.fill,
//           //   height: 1.h,
//           //   width: 30.w,
//           // ),
//           Container(
//               width: 30.w,
//               height: 5,
              // decoration: BoxDecoration(
              //     color: const Color(0xff2FA09C),
              //     shape: BoxShape.rectangle,
              //     image: DecorationImage(
              //       fit: BoxFit.fill,
              //       image: NetworkImage(img),
              //     ))),
//     );
//   }
// }
