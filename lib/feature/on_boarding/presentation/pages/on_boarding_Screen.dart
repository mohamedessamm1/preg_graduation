import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/widget_shared/custom_button_widget.dart';
import 'package:pregnant_care/feature/auth/login/presentation/pages/login_screen.dart';

import '../../../../core/shared/Colors/colors.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class Onboarding {
  String? title;
  String? txt;
  String? image;
  Onboarding({
    required this.title,
    required this.txt,
    required this.image,
  });
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool islast = false;
  int currentIndex = 0;
  List<Onboarding> onboardinglist = [
    Onboarding(
        title: 'welcome to the mothers',
        txt: 'your journey to confident parenting .',
        image: 'assets/images/one.jpg'),
    Onboarding(
        title: 'benefits overview',
        txt:
            'discover valuable resources,expert advice,and a supportivecommunity tailored for new mothers. ',
        image: 'assets/images/two.jpg'),
    Onboarding(
        title: 'how  to work',
        txt:
            'easily navigate through articles,consultations,and forums designed just for you. .',
        image: 'assets/images/three.jpg'),
    Onboarding(
        title: ' ',
        txt:
            'share the app with other mothers and help build a strong, supportive community!..',
        image: 'assets/images/four.jpg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: TextButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));

        }, child: Text('skip',style: TextStyle(color: Colors.white,fontSize: 16.sp),)),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: Image.asset(
                onboardinglist[currentIndex].image!,
                fit: BoxFit.cover,
              )),
          Container(
            height: 480.0,
            decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(0.0),
                      Colors.grey.shade900,
                    ],
                    stops: [
                      0.0,
                      1.4,
                    ])
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40.h),
            child: currentIndex == 3
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, bottom: 12.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text('${onboardinglist[currentIndex].txt}',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade400)),
                            ),
                          ],
                        ),
                      ),
                      customButton(
                          onTap: () {
                            setState(() {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));

                            });
                          },
                          text: 'get started',
                          icon: Icons.arrow_forward_ios_rounded),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: Row(
                          children: [
                            Text('${onboardinglist[currentIndex].title}',
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, bottom: 12.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text('${onboardinglist[currentIndex].txt}',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade400)),
                            ),
                          ],
                        ),
                      ),
                      customButton(
                          onTap: () {
                            setState(() {
                              if (currentIndex < 3) {
                                currentIndex++;
                              } else {
                                print('doneeee');
                              }
                            });
                          },
                          text: 'next'),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
