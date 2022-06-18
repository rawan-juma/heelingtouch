import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/controllers/sp_helper.dart';
import 'package:sizer/sizer.dart';

class StroyDetails extends StatelessWidget {
  const StroyDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text('عنوان قصة النجاح',
              style: TextStyle(color: const Color(0xffffffff), fontSize: 13.sp),
              textAlign: TextAlign.center),
          backgroundColor: const Color(0xff2FA09C),
          // elevation: 2,
          shadowColor: Colors.grey[100],
          systemOverlayStyle: SystemUiOverlayStyle.light,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
          ),
          //  IconButton(
          //   icon: Image.asset("assets/share-2.png"),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => NotificationScreen()),
          //     );
          //   },
          // ),
          automaticallyImplyLeading: false,
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.arrow_back_ios),
          //     onPressed: () {
          //       Navigator.pop(
          //         context,
          //       );
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
                      SpHelper.spHelper.getStoryImg(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // ImageSlideshow(
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
                  SpHelper.spHelper.getStoryDescription(),
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
