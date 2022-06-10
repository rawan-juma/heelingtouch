import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:heelingtouchproject/controllers/sp_helper.dart';
import 'package:heelingtouchproject/therapist/notifications_screen.dart';
import 'package:sizer/sizer.dart';

class ArticleDetails extends StatelessWidget {
  const ArticleDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(SpHelper.spHelper.getArticleTitle(),
              style: TextStyle(color: const Color(0xffffffff), fontSize: 13.sp),
              textAlign: TextAlign.center),
          backgroundColor: const Color(0xff2FA09C),
          // elevation: 2,
          shadowColor: Colors.grey[100],
          systemOverlayStyle: SystemUiOverlayStyle.light,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            // icon: Image.asset("assets/share-2.png"),
            onPressed: () {
              Navigator.pop(
                context,
              );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => NotificationScreen()),
              // );
            },
          ),
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.arrow_back_ios),
          //     onPressed: () {
          // Navigator.pop(
          //   context,
          // );
          //     },
          //   ),
          // ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 22.h,
                width: 90.w,
                margin: EdgeInsets.only(top: 2.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Image border
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(48), // Image radius
                    child: Image.network(
                      SpHelper.spHelper.getArticleImg(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                //  ImageSlideshow(
                //   width: double.infinity,
                //   height: 200,
                //   initialPage: 0,
                //   indicatorColor: Colors.blue,
                //   indicatorBackgroundColor: Colors.grey,
                //   onPageChanged: (value) {
                //     debugPrint('Page changed: $value');
                //   },
                //   autoPlayInterval: 3000,
                //   isLoop: true,
                //   children: [
                //     ClipRRect(
                //       borderRadius: BorderRadius.circular(20), // Image border
                //       child: SizedBox.fromSize(
                //         size: const Size.fromRadius(48), // Image radius
                //         child: Image.network(
                //           SpHelper.spHelper.getArticleImg(),
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //     ),
                //     ClipRRect(
                //       borderRadius: BorderRadius.circular(20), // Image border
                //       child: SizedBox.fromSize(
                //         size: const Size.fromRadius(48), // Image radius
                //         child: Image.asset(
                //           'assets/story.png',
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //     ),
                //     ClipRRect(
                //       borderRadius: BorderRadius.circular(20), // Image border
                //       child: SizedBox.fromSize(
                //         size: const Size.fromRadius(48), // Image radius
                //         child: Image.asset(
                //           'assets/story.png',
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ),
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(right: 5.w, top: 1.h),
                child: Text(
                  "ملخص",
                  style: TextStyle(
                      color: const Color(0xff2FA09C), fontSize: 14.sp),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(right: 5.w, top: 1.h),
                child: Text(
                  SpHelper.spHelper.getArticleDescription(),
                  style: TextStyle(
                      color: const Color(0xff000000), fontSize: 13.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
