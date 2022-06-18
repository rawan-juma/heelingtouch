import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/patient/article_details.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../controllers/app_provider.dart';
import '../controllers/sp_helper.dart';
import '../therapist/story_details.dart';

// ignore: must_be_immutable
class SearchArticle extends StatelessWidget {
  const SearchArticle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              toolbarHeight: 8.h,
              centerTitle: true,
              title: Container(
                width: double.infinity,
                height: 6.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
                child: TextField(
                  controller: appProvider.searchController,
                  onSubmitted: (controller) {
                    appProvider.searchArticle();
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          appProvider.searchController.clear();
                        },
                      ),
                      hintText: 'بحث',
                      hintStyle: const TextStyle(
                        fontFamily: 'NeoSansArabic',
                      ),
                      border: InputBorder.none),
                ),
              ),
              backgroundColor: const Color(0xff2FA09C),
              elevation: 0,
              // shadowColor: Colors.grey[100],
              automaticallyImplyLeading: false,
              leadingWidth: 10.w,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  // appProvider.search();
                  Navigator.pop(
                    context,
                  );
                },
              ),
            ),
            body: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: appProvider.searchedArticles.map((e) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ArticleDetails()));
                            SpHelper.spHelper.setArticleTitle(e.title);
                            SpHelper.spHelper
                                .setArticleDescription(e.description);
                            SpHelper.spHelper.setArticleImg(e.imgs);
                          },
                          child: Text(
                            e.title,
                            style: const TextStyle(
                              fontFamily: 'NeoSansArabic',
                            ),
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Divider(
                        height: 2.h,
                      )
                    ],
                  );
                }).toList()),
          ));
    });
  }
}
