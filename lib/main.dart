import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heelingtouchproject/controllers/app_provider.dart';
import 'package:heelingtouchproject/controllers/fb_notifications.dart';
import 'package:heelingtouchproject/main_screens/splash.dart';
import 'package:heelingtouchproject/patient/auth/sign_in.dart';
import 'package:heelingtouchproject/patient/auth/sign_up.dart';
import 'package:heelingtouchproject/patient/auth/verification_screen.dart';
import 'package:heelingtouchproject/patient/browse.dart';
import 'package:heelingtouchproject/patient/consultaion_request.dart';
import 'package:heelingtouchproject/patient/pateint_home.dart';
import 'package:heelingtouchproject/therapist/add_screen.dart';
import 'package:heelingtouchproject/therapist/consultation_requests.dart';
import 'package:heelingtouchproject/therapist/therapist_home.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'controllers/notification_helper.dart';
import 'controllers/sp_helper.dart';
import 'main_screens/register_fb.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'controllers/app_provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String?> selectNotificationSubject =
    BehaviorSubject<String?>();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

/// IMPORTANT: running the following code on its own won't work as there is
/// setup required for each platform head project.
///
/// Please download the complete example app from the GitHub repository where
/// all the setup has been done
late String initialRoute;
late final NotificationAppLaunchDetails? notificationAppLaunchDetails;
Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SpHelper.spHelper.initSharedPrefrences();
  await FbNotifications.initNotifications();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();

  await _configureLocalTimeZone();

  notificationAppLaunchDetails = !kIsWeb && Platform.isLinux
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          onDidReceiveLocalNotification: (
            int id,
            String? title,
            String? body,
            String? payload,
          ) async {
            didReceiveLocalNotificationSubject.add(
              ReceivedNotification(
                id: id,
                title: title,
                body: body,
                payload: payload,
              ),
            );
          });
  const MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );
  final LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(
    defaultActionName: 'Open notification',
    defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
    macOS: initializationSettingsMacOS,
    linux: initializationSettingsLinux,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    selectedNotificationPayload = payload;
    selectNotificationSubject.add(payload);
  });
  runApp(const MyApp());
}

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  void _requestPermissions() {
    NotificationHelper.notificationHelper.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    NotificationHelper.notificationHelper.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  @override
  void dispose() {
    NotificationHelper.notificationHelper.didReceiveLocalNotificationSubject
        .close();
    NotificationHelper.notificationHelper.selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return ChangeNotifierProvider(
      create: (context) {
        return AppProvider();
      },
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          navigatorKey: NavigationService.navigationKey,
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case Verification.routeName:
                return MaterialPageRoute(builder: (_) => const Verification());
              case SignIn.routeName:
                return MaterialPageRoute(builder: (_) => SignIn());
              case SignUp.routeName:
                return MaterialPageRoute(builder: (_) => const SignUp());
              case MyHomePage.routeName:
                return MaterialPageRoute(builder: (_) => const MyHomePage());
              case MyHomePage1.routeName:
                return MaterialPageRoute(builder: (_) => const MyHomePage1());
              case FirstRigestrePage.routeName:
                return MaterialPageRoute(
                    builder: (_) => const FirstRigestrePage());
              default:
                return null;
            }
          },
          scaffoldMessengerKey: snackbarKey, // <= this

          title: 'Flutter Demo',
          theme: ThemeData(
              // primarySwatch: Colors.blue,
              ),
          debugShowCheckedModeBanner: false,
          home: const Splash(),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const routeName = '/therapistHome';

  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CurvedNavBar(
          actionButton: CurvedActionBar(
              onTab: (value) {
                /// perform action here
                log(value.toString());
              },
              activeIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Color(0xff2FA09C), shape: BoxShape.circle),
                child: const Icon(
                  Icons.close,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              inActiveIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Color(0xff2FA09C), shape: BoxShape.circle),
                child: const Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              text: "?????????? ??????"),
          activeColor: const Color(0xff2FA09C),
          navBarBackgroundColor: Colors.white,
          inActiveColor: Colors.black45,
          appBarItems: [
            FABBottomAppBarItem(
                activeIcon: Image.asset("assets/homeA.png"),
                inActiveIcon: Image.asset("assets/calender.png"),
                text: '??????????????'),
            FABBottomAppBarItem(
                activeIcon: Image.asset("assets/consultationA.png"),
                inActiveIcon: Image.asset("assets/quastion.png"),
                text: '?????????? ??????????????????'),
          ],
          bodyItems: const [
            Home(),
            ConsultationRequests(),
          ],
          actionBarView: AddStoryScreen()),
    );
  }
}

class MyHomePage1 extends StatefulWidget {
  static const routeName = '/patientHome';

  const MyHomePage1({Key? key}) : super(key: key);
  @override
  _MyHomePageState1 createState() => _MyHomePageState1();
}

class _MyHomePageState1 extends State<MyHomePage1> {
  @override
  void initState() {
    super.initState();
    // AppProvider appProvider = AppProvider();
    // appProvider.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CurvedNavBar(
        actionButton: CurvedActionBar(
            onTab: (value) {
              /// perform action here
              log(value.toString());
            },
            activeIcon: Container(
              height: 65,
              width: 65,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: Color(0xff2FA09C), shape: BoxShape.circle),
              child: SvgPicture.asset("assets/Consultaion.svg",
                  semanticsLabel: 'Consultaion icon'),
            ),
            inActiveIcon: Container(
              height: 65,
              width: 65,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: Color(0xff2FA09C), shape: BoxShape.circle),
              child: SvgPicture.asset("assets/Consultaion.svg",
                  semanticsLabel: 'Consultaion icon'),
            ),
            text: "??????????????????"),
        activeColor: const Color(0xff2FA09C),
        navBarBackgroundColor: Colors.white,
        inActiveColor: Colors.black45,
        appBarItems: [
          FABBottomAppBarItem(
              activeIcon: SvgPicture.asset("assets/Home0.svg",
                  semanticsLabel: 'home icon'),
              inActiveIcon: SvgPicture.asset("assets/Home.svg",
                  semanticsLabel: 'home icon'),
              text: '????????????????'),
          FABBottomAppBarItem(
              activeIcon: SvgPicture.asset("assets/Play.svg",
                  semanticsLabel: 'play icon'),
              inActiveIcon: SvgPicture.asset("assets/Play0.svg",
                  semanticsLabel: 'play icon'),
              text: '?????????????? ??????????'),
        ],
        bodyItems: const [
          PatientHome(),
          Browse(),
        ],
        actionBarView: const ConsultaionRequest(),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final TextEditingController _numberCtrl = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _numberCtrl.text = "085921191121";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: _numberCtrl,
//                 decoration: const InputDecoration(labelText: "Phone Number"),
//                 keyboardType: TextInputType.number,
//               ),
//             ),
//             ElevatedButton(
//               child: const Text("Test Call"),
//               onPressed: () async {
//                 FlutterPhoneDirectCaller.callNumber(_numberCtrl.text);
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// import 'login.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginScreen(),
//       debugShowCheckedModeBanner: false,
//       color: Colors.indigo[900],
//     );
//   }
// }
