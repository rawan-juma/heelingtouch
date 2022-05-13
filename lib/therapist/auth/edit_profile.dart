import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/widgets/app_button.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text('تعديل المعلومات الشخصية',
                style:
                    TextStyle(color: const Color(0xffffffff), fontSize: 13.sp),
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
                        const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage("assets/tt.png"),
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
                        color: const Color(0xff2FA09C), fontSize: 13.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5.w, left: 5.w),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: descriptionController,
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "مريم سعيد",
                      hintStyle: TextStyle(
                          fontSize: 11.sp, color: const Color(0xff000000)),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(right: 6.w, top: 1.h),
                  child: Text(
                    "رقم الهاتف",
                    style: TextStyle(
                        color: const Color(0xff2FA09C), fontSize: 13.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5.w, left: 5.w),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: descriptionController,
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "0595521535",
                      hintStyle: TextStyle(
                          fontSize: 11.sp, color: const Color(0xff000000)),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(right: 6.w, top: 1.h),
                  child: Text(
                    "الوصف",
                    style: TextStyle(
                        color: const Color(0xff2FA09C), fontSize: 13.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5.w, left: 5.w),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    controller: descriptionController,
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: Colors.black),
                    minLines: 3,
                    decoration: InputDecoration(
                      hintText:
                          "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق",
                      hintStyle: TextStyle(
                          fontSize: 11.sp, color: const Color(0xff000000)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h, bottom: 15.h),
                  child: App_Button('حفظ التعديلات', 90.w, () {
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
  }
}
