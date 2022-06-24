import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class ConsultationItem extends StatefulWidget {
  String id;
  String name;
  String img;
  String time;
  ConsultationItem(this.id, this.name, this.img, this.time, {Key? key})
      : super(key: key);

  @override
  State<ConsultationItem> createState() => _ConsultationItemState();
}

class _ConsultationItemState extends State<ConsultationItem> {
  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Consumer<AppProvider>(builder: (context, appProvider, x) {
    return GestureDetector(
        onTap: () {},
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                height: 15.h,
                width: 360.w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Card(
                  elevation: 2.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 15.w,
                              height: 13.h,
                              decoration: BoxDecoration(
                                  color: const Color(0xff2FA09C),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: widget.img == ""
                                        ? const NetworkImage(
                                            "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-Vector-PNG-Clipart.png",
                                          )
                                        : NetworkImage(widget.img),
                                  ))),
                          SizedBox(
                            width: 2.w,
                          ),
                          SizedBox(
                            width: 70.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      widget.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.black,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: 'NeoSansArabic',
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Container(
                                        width: 22.w,
                                        height: 2.5.h,
                                        decoration: const BoxDecoration(
                                            color: Colors.transparent,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/callBtn.png"),
                                            ))),
                                  ],
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      widget.time,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: const Color(0xff000000),
                                        fontFamily: 'NeoSansArabic',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // const Divider(),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Row(
                      //       children: const [
                      //         Icon(
                      //           Icons.done,
                      //           color: Color(0xff05CF6A),
                      //         ),
                      //         Text(
                      //           'قبول',
                      //           style: TextStyle(
                      //             fontSize: 16,
                      //             color: Color(0xff05CF6A),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
