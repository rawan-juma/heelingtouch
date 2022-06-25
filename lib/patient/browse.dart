import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heelingtouchproject/patient/search_article.dart';
import 'package:heelingtouchproject/widgets/article_item.dart';
import 'package:heelingtouchproject/widgets/video_item.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../controllers/app_provider.dart';
import '../therapist/notifications_screen.dart';

class Browse extends StatelessWidget {
  const Browse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
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
                        fontFamily: 'NeoSansArabic',
                        color: const Color(0xffffffff),
                        fontSize: 13.sp),
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
                    icon: SvgPicture.asset("assets/Search.svg",
                        semanticsLabel: 'search icon'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchArticle()),
                      );
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset("assets/Notification.svg",
                        semanticsLabel: 'notification icon'),
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
                      // text: "فيديوهات",
                      child: Text(
                        "فيديوهات",
                        style: TextStyle(
                          fontFamily: 'NeoSansArabic',
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "مقالات",
                        style: TextStyle(
                          fontFamily: 'NeoSansArabic',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: appProvider.videosList.map((e) {
                        return VideoItem(
                            e.id, e.title, e.description, e.imgs, e.url);
                      }).toList()),
                  ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: appProvider.articlesList.map((e) {
                        return ArticleItem(
                            e.id, e.title, e.description, e.imgs);
                      }).toList()),
                ],
              ),
            ),
          ));
    });
  }
}
