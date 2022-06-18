import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/widgets/app_button.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../controllers/app_provider.dart';

// ignore: must_be_immutable
class EditPatientProfile extends StatelessWidget {
  EditPatientProfile({Key? key}) : super(key: key);
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
                icon: const Icon(Icons.arrow_back_ios),
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
                              backgroundImage: appProvider.user!.imageUrl != ""
                                  ? NetworkImage(appProvider.user!.imageUrl)
                                      as ImageProvider
                                  : const AssetImage("assets/tt.png"),
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
                          fontSize: 12.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.w, left: 5.w),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: appProvider.usernameController,
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: appProvider.user!.username,
                        hintStyle: TextStyle(
                            fontFamily: 'NeoSansArabic',
                            fontSize: 10.sp,
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
                      enabled: false,
                      controller: appProvider.phoneController,
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: appProvider.user!.phone,
                        hintStyle: TextStyle(
                            fontFamily: 'NeoSansArabic',
                            fontSize: 10.sp,
                            color: const Color(0xff000000)),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(right: 6.w, top: 1.h),
                    child: Text(
                      "العنوان",
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
                      controller: appProvider.addressController,
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: Colors.black),
                      minLines: null,
                      decoration: InputDecoration(
                        hintText: appProvider.user!.address,
                        hintStyle: TextStyle(
                            fontFamily: 'NeoSansArabic',
                            fontSize: 10.sp,
                            color: const Color(0xff000000)),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(right: 6.w, top: 1.h),
                    child: Text(
                      "العمر",
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
                      controller: appProvider.ageController,
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: Colors.black),
                      minLines: null,
                      decoration: InputDecoration(
                        hintText: appProvider.user!.age,
                        hintStyle: TextStyle(
                            fontFamily: 'NeoSansArabic',
                            fontSize: 10.sp,
                            color: const Color(0xff000000)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5.h,
                    ),
                    child: App_Button('حفظ التعديلات', 90.w, () {
                      appProvider.updateProfile();
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
