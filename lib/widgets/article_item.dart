import 'package:flutter/material.dart';
import 'package:heelingtouchproject/patient/article_details.dart';
import 'package:heelingtouchproject/patient/therapist_page.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../controllers/sp_helper.dart';

// ignore: must_be_immutable
class ArticleItem extends StatelessWidget {
  String id;
  String title;
  String description;
  String img;
  ArticleItem(this.id, this.title, this.description, this.img, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return Consumer<AppProvider>(builder: (context, appProvider, x) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ArticleDetails()));
            SpHelper.spHelper.setArticleTitle(title);
            SpHelper.spHelper.setArticleDescription(description);
            SpHelper.spHelper.setArticleImg(img);
            // SpHelper.spHelper.setTherapistBio(bio);
            // SpHelper.spHelper.setTherapistImg(img);
            // SpHelper.spHelper.setTherapistPhoneNumber(phone);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 17.h,
              child: Card(
                elevation: 2.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 15.h,
                            width: 28.w,
                            decoration: BoxDecoration(
                                color: const Color(0xff2FA09C),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(img == ""
                                      ? "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-Vector-PNG-Clipart.png"
                                      : img),
                                )),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 60.w,
                                child: Text(
                                  title,
                                  style: TextStyle(
                                      fontFamily: 'NeoSansArabic',
                                      fontSize: 12.sp,
                                      color: const Color(0xff2FA09C),
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Visibility(
                                visible: true,
                                child: SizedBox(
                                  width: 60.w,
                                  child: Text(
                                    description,
                                    style: const TextStyle(
                                      height: 1.3,
                                      fontFamily: 'NeoSansArabic',
                                      color: Color(0xff1D1D1D),
                                    ),
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    softWrap: true,
                                  ),
                                ),
                              ),

                              // ),
                            ],
                          ),
                        ],
                      ),

                      // SizedBox(
                      //   width: 40.w,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
