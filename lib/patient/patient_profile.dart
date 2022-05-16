import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/patient/personal_info.dart';
import 'package:heelingtouchproject/patient/settings.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:sizer/sizer.dart';
import '../therapist/notifications_screen.dart';
import 'change_passwod.dart';

class PatientProfile extends StatelessWidget {
  const PatientProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text('بروفايلي',
                  style: TextStyle(
                      color: const Color(0xffffffff), fontSize: 13.sp),
                  textAlign: TextAlign.center),
              backgroundColor: const Color(0xff2FA09C),
              // elevation: 2,
              shadowColor: Colors.grey[100], automaticallyImplyLeading: false,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              leading: IconButton(
                icon: Image.asset("assets/Arrow - Right 2.png"),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),

              actions: [
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
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/patientCover.png",
                          ),
                        ),
                        Center(
                          child: Container(
                              width: 27.w,
                              height: 24.h,
                              decoration: const BoxDecoration(
                                  color: Color(0xffc0c0c0),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/personP.png"),
                                  ))),
                        ),
                      ],
                    ),
                    Text(
                      "الاء رائد بصل",
                      style: TextStyle(fontSize: 13.sp),
                    ),
                    SizedBox(
                      height: 50.h,
                      child: SettingsList(
                        lightTheme: const SettingsThemeData(
                            settingsSectionBackground: Colors.black,
                            dividerColor: Colors.red,
                            settingsListBackground: Colors.white),
                        sections: [
                          SettingsSection(
                            tiles: <SettingsTile>[
                              SettingsTile.navigation(
                                  title: Text(
                                    'المعلومات الشخصية',
                                    style: TextStyle(fontSize: 13.sp),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                  onPressed: (context) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PersonalInformation()),
                                    );
                                  }),
                            ],
                          ),
                          SettingsSection(
                            tiles: <SettingsTile>[
                              SettingsTile.navigation(
                                  title: Text(
                                    'تذاكري',
                                    style: TextStyle(fontSize: 13.sp),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                  onPressed: (context) {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => MyAppointments()),
                                    // );
                                  }),
                            ],
                          ),
                          SettingsSection(
                            tiles: <SettingsTile>[
                              SettingsTile.navigation(
                                  title: Text(
                                    'استشاراتي',
                                    style: TextStyle(fontSize: 13.sp),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                  onPressed: (context) {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => MyAppointments()),
                                    // );
                                  }),
                            ],
                          ),
                          SettingsSection(
                            tiles: <SettingsTile>[
                              SettingsTile.navigation(
                                  title: Text(
                                    'تغيير كلمة المرور',
                                    style: TextStyle(fontSize: 13.sp),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                  onPressed: (context) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangePatientPassword()),
                                    );
                                  }),
                            ],
                          ),
                          SettingsSection(
                            tiles: <SettingsTile>[
                              SettingsTile.navigation(
                                  title: Text(
                                    'الاعدادات',
                                    style: TextStyle(fontSize: 13.sp),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                  onPressed: (context) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PatientSettings()),
                                    );
                                  }),
                            ],
                          ),
                          SettingsSection(
                            tiles: <SettingsTile>[
                              SettingsTile.navigation(
                                  title: Text(
                                    'تسجيل الخروج',
                                    style: TextStyle(fontSize: 13.sp),
                                  ),
                                  onPressed: (context) {}),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}