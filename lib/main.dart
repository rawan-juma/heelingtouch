import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/controllers/app_provider.dart';
import 'package:heelingtouchproject/patient/auth/sign_in.dart';
import 'package:heelingtouchproject/patient/auth/sign_up.dart';
import 'package:heelingtouchproject/patient/auth/verification_screen.dart';
import 'package:heelingtouchproject/patient/browse.dart';
import 'package:heelingtouchproject/patient/pateint_home.dart';
import 'package:heelingtouchproject/therapist/add_screen.dart';
import 'package:heelingtouchproject/therapist/consultation_requests.dart';
import 'package:heelingtouchproject/therapist/therapist_home.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'controllers/sp_helper.dart';
import 'main_screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SpHelper.spHelper.initSharedPrefrences();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          routes: {
            Verification.routeName: (context) => const Verification(),
            SignIn.routeName: (context) => SignIn(),
            SignUp.routeName: (context) => const SignUp(),
            PatientHome.routeName: (context) => PatientHome(),
            MyHomePage1.routeName: (context) => const MyHomePage1(),
          },
          title: 'Flutter Demo',
          theme: ThemeData(
              // primarySwatch: Colors.blue,
              ),
          debugShowCheckedModeBanner: false,
          home: PatientHome(),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
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
              text: "اضافة قصة"),
          activeColor: const Color(0xff2FA09C),
          navBarBackgroundColor: Colors.white,
          inActiveColor: Colors.black45,
          appBarItems: [
            FABBottomAppBarItem(
                activeIcon: Image.asset("assets/homeA.png"),
                inActiveIcon: Image.asset("assets/calender.png"),
                text: 'مواعيدي'),
            FABBottomAppBarItem(
                activeIcon: Image.asset("assets/consultationA.png"),
                inActiveIcon: Image.asset("assets/quastion.png"),
                text: 'طلبات الاستشارة'),
          ],
          bodyItems: [
            const Home(),
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
              child: Image.asset(
                "assets/myConsultations.png",
                height: 50,
                width: 50,
              ),
            ),
            inActiveIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: Color(0xff2FA09C), shape: BoxShape.circle),
              child: Image.asset(
                "assets/myConsultations.png",
                height: 50,
                width: 50,
              ),
            ),
            text: "للاستشارة"),
        activeColor: const Color(0xff2FA09C),
        navBarBackgroundColor: Colors.white,
        inActiveColor: Colors.black45,
        appBarItems: [
          FABBottomAppBarItem(
              activeIcon: Image.asset("assets/Home.png"),
              inActiveIcon: Image.asset("assets/InHome.png"),
              text: 'الرئيسية'),
          FABBottomAppBarItem(
              activeIcon: Image.asset("assets/play.png"),
              inActiveIcon: Image.asset("assets/InPlay.png"),
              text: 'التصفح'),
        ],
        bodyItems: [
          PatientHome(),
          //  PatientHome(),
          const Browse(),
        ],
        actionBarView: PatientHome(),
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
