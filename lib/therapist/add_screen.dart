// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/controllers/app_provider.dart';
import 'package:heelingtouchproject/controllers/firebase_helper.dart';
import 'package:heelingtouchproject/therapist/notifications_screen.dart';
import 'package:heelingtouchproject/widgets/app_button.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// ignore: must_be_immutable
class AddStoryScreen extends StatelessWidget {
  AddStoryScreen({Key? key}) : super(key: key);
  int isFirst = 1;
  final List<String> imgList = [
    'assets/story.png',
    'assets/story.png',
    'assets/story.png'
  ];
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              centerTitle: true,
              title: Text('إضافة قصة نجاح',
                  style: TextStyle(
                      color: const Color(0xffffffff), fontSize: 13.sp),
                  textAlign: TextAlign.center),
              backgroundColor: const Color(0xff2FA09C),
              // elevation: 2,
              automaticallyImplyLeading: false,
              shadowColor: Colors.grey[100],
              systemOverlayStyle: SystemUiOverlayStyle.light,
              actions: [
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
              ]),
          body: SizedBox(
              child: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Container(
                  //   margin: const EdgeInsets.all(15),
                  //   child: CarouselSlider.builder(
                  //     itemCount: imgList.length,
                  //     options: CarouselOptions(
                  //       enlargeCenterPage: true,
                  //       height: 30.h,
                  //       autoPlay: false,
                  //       autoPlayInterval: const Duration(seconds: 0),
                  //       reverse: false,
                  //       aspectRatio: 5.0,
                  //     ),
                  //     itemBuilder: (context, i, id) {
                  //       //for onTap to redirect to another screen
                  //       return GestureDetector(
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(15),
                  //               border: Border.all(
                  //                 color: Colors.white,
                  //               )),
                  //           //ClipRRect for image border radius
                  //           child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(15),
                  //             child: Image.asset(
                  //               imgList[i],
                  //               width: 80.w,
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  //         onTap: () {
                  //           var url = imgList[i];
                  //           log(url.toString());
                  //         },
                  //       );
                  //     },
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Container(
                        width: 310,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    FirestoreHelper.firestoreHelper.imageUrl !=
                                            ""
                                        ? NetworkImage(FirestoreHelper
                                            .firestoreHelper.imageUrl)
                                        : const AssetImage('assets/story.png')
                                            as ImageProvider)),
                        // child: Center(
                        //   child: IconButton(
                        //       icon: Icon(Icons.add_a_photo,
                        //           color: Colors.yellow[600]),
                        //       onPressed: () {
                        // print(
                        //     'imaaaaaaaaaaaaaaaage${FirestoreHelper.firestoreHelper.imageUrl}');

                        // }),
                        // ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 90.w,
                    height: 8.h,
                    child: FlatButton(
                      onPressed: () {
                        appProvider.uploadImage();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.camera_alt,
                            color: Color(0xff2FA09C),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text('إضافة صورة',
                              style: TextStyle(
                                  color: const Color(0xff2FA09C),
                                  fontSize: 14.sp)),
                        ],
                      ),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Color(0xff2FA09C),
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(right: 5.w, top: 1.h),
                    child: Text(
                      "الوصف",
                      style: TextStyle(
                          color: const Color(0xff2FA09C), fontSize: 14.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.w, left: 5.w),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: appProvider.storyDescriptionController,
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "اسال شيئا",
                        hintStyle: TextStyle(
                            fontSize: 11.sp, color: const Color(0xff000000)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h, bottom: 15.h),
                    child: App_Button('نشر', 90.w, () {
                      appProvider.addStory();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const Home()),
                      // );
                    }),
                  ),
                ],
              ),
            ),
          )));
    });
  }
}
