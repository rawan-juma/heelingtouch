import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:heelingtouchproject/patient/therapist_page.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/sp_helper.dart';

// ignore: must_be_immutable
class VideoItem extends StatelessWidget {
  String id;
  String title;
  String description;
  String img;
  String url;
  VideoItem(this.id, this.title, this.description, this.img, this.url,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return Consumer<AppProvider>(builder: (context, appProvider, x) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GestureDetector(
          onTap: () async {
            final Uri _url = Uri.parse(url);

            if (!await launchUrl(
              _url,
              mode: LaunchMode.inAppWebView,
              webViewConfiguration:
                  const WebViewConfiguration(enableDomStorage: false),
            )) {
              throw 'Could not launch $url';
            }
            // try {
            //   await canLaunch(url)
            //       ? launch(url, forceWebView: true, enableJavaScript: true)
            //       : throw 'could\'t launch Url';
            // } catch (err) {
            //   log(err.toString());
            // }
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const TherapistDetails()));
            // SpHelper.spHelper.setTherapistID(id);
            // SpHelper.spHelper.setTherapistFname(fName);
            // SpHelper.spHelper.setTherapistLname(lName);
            // SpHelper.spHelper.setTherapistBio(bio);
            // SpHelper.spHelper.setTherapistImg(img);
            // SpHelper.spHelper.setTherapistPhoneNumber(phone);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 25.h,
              child: Card(
                elevation: 2.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child:
                    //  Padding(
                    // padding: const EdgeInsets.all(8.0),
                    // child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Row(
                    //       children: [
                    Container(
                  height: 15.h,
                  width: 28.w,
                  decoration: BoxDecoration(
                      color: const Color(0xff2FA09C),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(img == ""
                            ? "https://silverberryphysio.com/wp-content/uploads/2021/06/Silverberry-Physiotherapy-Welcome-Section-.png"
                            : img),
                      )),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Styles.colorWhite,
                      gradient: LinearGradient(
                          // tileMode: TileMode.,
                          // begin: Alignment(0.0, -0.1),
                          // end: Alignment(0.0, 0.1),
                          colors: [
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.4)
                          ]),
                      // ),
                      // color: Colors.black.withOpacity(0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.0, top: 15.h),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 100.w,
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
                              width: 100.w,
                              child: Text(
                                description,
                                style: const TextStyle(
                                  height: 1.3,
                                  fontFamily: 'NeoSansArabic',
                                  color: Color(0xffffffff),
                                ),
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
