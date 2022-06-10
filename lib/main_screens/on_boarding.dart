// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/main_screens/register_fb.dart';
import 'package:heelingtouchproject/widgets/slide.dart';
import 'package:sizer/sizer.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  int _currentPage = 0;
  int i = 0;
  final PageController _pageController = PageController(initialPage: 0);

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }

    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: isActive ? 8.0 : 8.0,
      width: isActive ? 25.0 : 25.0,
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xff20B2AF)
            : _currentPage == 0
                ? const Color(0xffD5D5D5)
                : _currentPage == 1
                    ? const Color(0xffD5D5D5)
                    : const Color(0xffD5D5D5),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: Padding(
          padding: EdgeInsets.only(top: 1.5.h),
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FirstRigestrePage()),
                );
              },
              child: Text(
                'تخطي',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                    fontFamily: 'NeoSansArabic'),
                textAlign: TextAlign.right,
              )),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(
        //       Icons.arrow_forward_ios,
        //       color: Colors.black,
        //     ),
        //     onPressed: () {
        //       // Navigator.push(
        //       //   context,
        //       //   MaterialPageRoute(builder: (context) => Favorits()),
        //       // );
        //     },
        //   ),
        // ]
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 85.h,
                child: PageView(
                  physics: const ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    Slide(
                      'assets/onB1.png',
                      'حدد موعدًا عبر الإنترنت',
                      'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.',
                    ),
                    Slide(
                      'assets/onB2.png',
                      'الكثير من التمارين المفيدة',
                      'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.',
                    ),
                    Slide(
                      'assets/onB3.png',
                      'مكالمات للتشاور',
                      'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.',
                    )
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
