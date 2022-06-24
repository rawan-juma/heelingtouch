import 'dart:developer';

import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/controllers/auth_helper.dart';
import 'package:heelingtouchproject/controllers/firebase_helper.dart';
import 'package:heelingtouchproject/controllers/sp_helper.dart';
import 'package:heelingtouchproject/model/messege.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../controllers/app_provider.dart';

class ChatDetails extends StatelessWidget {
  const ChatDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: const Color(0xff2FA09C),
            shadowColor: Colors.grey[100],
            systemOverlayStyle: SystemUiOverlayStyle.light,
            leading: IconButton(
              icon: const Icon(Icons.call_outlined),
              color: Colors.white,
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const Search()),
                // );
              },
            ),
            actions: [
              Center(
                child: Text(
                  "مريم سعيد",
                  style: TextStyle(
                    fontFamily: 'NeoSansArabic',
                    color: Colors.white,
                    fontSize: 13.sp,
                  ),
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              Container(
                  width: 10.w,
                  height: 11.h,
                  decoration: const BoxDecoration(
                      color: Color(0xff2FA09C),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/personP.png"),
                      ))),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),
            ],
          ),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: SizedBox(
                height: 250.h,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FutureBuilder<List<MessageModel>>(
                        future: appProvider.getMessages(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            log("message");
                            for (int i = 0;
                                i <= snapshot.data!.length - 1;
                                i++) {
                              log("message!!!! = ${snapshot.data!.length}");
                              return
                                  // Column(
                                  //   children: [
                                  ListView(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      children: snapshot.data!.map((e) {
                                        // appProvider.get
                                        if (e.senderId ==
                                            AuthHelper.authHelper.firebaseAuth
                                                .currentUser!.uid) {
                                          return BubbleNormal(
                                            text: e.content,
                                            isSender: false,
                                            color: const Color(0xFFDFDFDF),
                                            tail: false,
                                            textStyle: TextStyle(
                                              fontFamily: 'NeoSansArabic',
                                              fontSize: 11.sp,
                                              color: Colors.black,
                                            ),
                                          );
                                        } else {
                                          return BubbleNormal(
                                            text: e.content,
                                            textStyle: TextStyle(
                                              fontFamily: 'NeoSansArabic',
                                              fontSize: 11.sp,
                                              color: Colors.white,
                                            ),
                                            color: const Color(0xFF2FA09C),
                                            tail: false,
                                            sent: true,
                                            seen: false,
                                            delivered: false,
                                          );
                                        }
                                      }).toList());

                              //   ],
                              // );
                            }
                            return const Center(
                                child: Text("!!!!!ابدأ محادثة"));
                          } else {
                            return const Center(child: Text("ابدأ محادثة"));
                          }
                        },
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Image.asset('assets/sendBtn.png'),
                            iconSize: 60.0,
                            onPressed: () {
                              FirestoreHelper.firestoreHelper.fetchmessages();
                              appProvider.updateChat(
                                  AuthHelper
                                      .authHelper.firebaseAuth.currentUser!.uid,
                                  SpHelper.spHelper.getTherapisID());
                              appProvider.messageController.clear();
                            },
                          ),
                          SizedBox(
                            height: 6.5.h,
                            width: 80.w,
                            child: TextField(
                              controller: appProvider.messageController,
                              textAlign: TextAlign.right,
                              decoration: const InputDecoration(
                                hintText: 'اكتب رسالتك هنا',
                                hintStyle: TextStyle(
                                  fontFamily: 'NeoSansArabic',
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                        // ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
