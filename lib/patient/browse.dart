import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '../therapist/notifications_screen.dart';
import '../widgets/article_item.dart';

class Browse extends StatelessWidget {
  const Browse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text('المحتوى الطبي',
                  style: TextStyle(
                      color: const Color(0xffffffff), fontSize: 13.sp),
                  textAlign: TextAlign.center),
              backgroundColor: const Color(0xff2FA09C),
              // elevation: 2,
              shadowColor: Colors.grey[100], automaticallyImplyLeading: false,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              // leading: IconButton(
              //   icon: Image.asset("assets/Arrow - Right 2.png"),
              //   onPressed: () {
              //     Navigator.pop(
              //       context,
              //     );
              //   },
              // ),

              actions: [
                IconButton(
                  icon: Image.asset("assets/Search.png"),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Settings()),
                    // );
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
              bottom: const TabBar(
                indicatorColor: Color(0xffffffff),
                tabs: [
                  Tab(
                    // icon: Icon(Icons.directions_car),
                    text: "فيديوهات",
                  ),
                  Tab(
                    text: "مقالات",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ArticleItem(
                    "hhh",
                    "jbkjbsgihweisghndknzgklbnglznlgnzsngizsgihiosgiogiozhgiozhzgioho",
                    "assets/tt.png"),
                // Icon(Icons.directions_car),
                const Icon(Icons.directions_transit),
              ],
            ),
          ),
        ));
  }
}
