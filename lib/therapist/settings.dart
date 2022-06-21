import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/therapist/appointments.dart';
import 'package:heelingtouchproject/therapist/auth/change_password.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:sizer/sizer.dart';

import '../controllers/app_provider.dart';

// ignore: must_be_immutable
class Settings extends StatelessWidget {
  bool isSwitched = false;

  Settings({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text('الإعدادات',
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
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: SettingsList(
              lightTheme: const SettingsThemeData(
                  settingsSectionBackground: Colors.black,
                  dividerColor: Colors.red,
                  settingsListBackground: Colors.white),
              sections: [
                SettingsSection(
                  // title: Text('Common'),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      leading: Image.asset("assets/meet.png"),
                      title: Text(
                        'مواعيدي',
                        style: TextStyle(fontSize: 13.sp),
                      ),
                      // value: Text('English'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                      onPressed: (context) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyAppointments()),
                      ),
                    ),
                    SettingsTile.navigation(
                      leading: Image.asset("assets/Lock.png"),
                      title: Text(
                        'تغيير كلمة المرور',
                        style: TextStyle(fontSize: 13.sp),
                      ),
                      // value: Text('English'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                      onPressed: (context) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePassword()),
                      ),
                    ),
                    SettingsTile.switchTile(
                      onToggle: (value) {},
                      initialValue: true,
                      activeSwitchColor: const Color(0xff2FA09C),
                      leading: Image.asset("assets/Notification1.png"),
                      title: Text(
                        'الإشعارات',
                        style: TextStyle(fontSize: 13.sp),
                      ),
                    ),
                    SettingsTile.navigation(
                      leading: Image.asset("assets/Password.png"),
                      title: Text(
                        'شروط المستخدم',
                        style: TextStyle(fontSize: 13.sp),
                      ),
                      // value: Text('English'),
                    ),
                    SettingsTile.navigation(
                      leading: Image.asset("assets/Logout.png"),
                      title: Text(
                        'تسجيل الخروج',
                        style: TextStyle(fontSize: 13.sp),
                      ),
                      onPressed: (context) => appProvider.logout(),

                      // value: Text('English'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
