import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/controllers/sp_helper.dart';
import 'package:heelingtouchproject/widgets/app_button.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/app_provider.dart';
import '../../controllers/firebase_helper.dart';

// ignore: must_be_immutable
class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text('تعديل المعلومات الشخصية',
                  style: TextStyle(
                      fontFamily: 'NeoSansArabic',
                      color: const Color(0xffffffff),
                      fontSize: 13.sp),
                  textAlign: TextAlign.center),
              backgroundColor: const Color(0xff2FA09C),
              // elevation: 2,
              shadowColor: Colors.grey[100],
              systemOverlayStyle: SystemUiOverlayStyle.light,
              leading: IconButton(
                icon: Image.asset("assets/Arrow - Right 2.png"),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 2.h),
                      height: 115,
                      width: 115,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          GestureDetector(
                            onTap: () {
                              appProvider.uploadImage();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  FirestoreHelper.firestoreHelper.imageUrl != ""
                                      ? NetworkImage(FirestoreHelper
                                          .firestoreHelper
                                          .imageUrl) as ImageProvider
                                      : NetworkImage(
                                          SpHelper.spHelper.getTherapisImg()),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: -25,
                              child: RawMaterialButton(
                                onPressed: () {},
                                elevation: 2.0,
                                fillColor: const Color(0xFFECECEC),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Color(0xff20B2AF),
                                ),
                                padding: const EdgeInsets.all(5.0),
                                shape: const CircleBorder(),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(right: 6.w, top: 1.h),
                    child: Text(
                      "اسم المستخدم",
                      style: TextStyle(
                          fontFamily: 'NeoSansArabic',
                          color: const Color(0xff2FA09C),
                          fontSize: 11.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.w, left: 5.w),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: appProvider.usernameController,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          fontFamily: 'NeoSansArabic', color: Colors.black),
                      decoration: InputDecoration(
                        hintText: SpHelper.spHelper.getTherapisFname() == ""
                            ? "اسم المستخدم"
                            : SpHelper.spHelper.getTherapisFname(),
                        hintStyle: TextStyle(
                            fontFamily: 'NeoSansArabic',
                            fontSize: 11.sp,
                            color: const Color(0xff000000)),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(right: 6.w, top: 1.h),
                    child: Text(
                      "رقم الهاتف",
                      style: TextStyle(
                          fontFamily: 'NeoSansArabic',
                          color: const Color(0xff2FA09C),
                          fontSize: 12.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.w, left: 5.w),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: appProvider.phoneController,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          fontFamily: 'NeoSansArabic', color: Colors.black),
                      decoration: InputDecoration(
                        hintText:
                            SpHelper.spHelper.getTherapisPhoneNumber() == ""
                                ? "رقم الهاتف"
                                : SpHelper.spHelper.getTherapisPhoneNumber(),
                        hintStyle: TextStyle(
                            fontFamily: 'NeoSansArabic',
                            fontSize: 11.sp,
                            color: const Color(0xff000000)),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(right: 6.w, top: 1.h),
                    child: Text(
                      "الوصف",
                      style: TextStyle(
                          fontFamily: 'NeoSansArabic',
                          color: const Color(0xff2FA09C),
                          fontSize: 12.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.w, left: 5.w),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      controller: appProvider.bioController,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          fontFamily: 'NeoSansArabic', color: Colors.black),
                      minLines: 3,
                      decoration: InputDecoration(
                        hintText: SpHelper.spHelper.getTherapisBio() == ""
                            ? "نبذة عما تفعله"
                            : SpHelper.spHelper.getTherapisBio(),
                        hintStyle: TextStyle(
                            fontFamily: 'NeoSansArabic',
                            fontSize: 11.sp,
                            color: const Color(0xff000000)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h, bottom: 15.h),
                    child: App_Button('حفظ التعديلات', 90.w, () {
                      appProvider.updateTherapistProfileData();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const Home()),
                      // );
                    }),
                  ),
                ],
              ),
            )),
      );
    });
  }
}
