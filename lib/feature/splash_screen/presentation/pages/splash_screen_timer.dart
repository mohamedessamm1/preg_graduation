
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pregnant_care/core/shared/Cache/local_cache.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';

import '../../../layout/presentation/pages/HomeLayout.dart';
import '../../../on_boarding/presentation/pages/on_boarding_Screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 7), () {
      print(CacheHelper.getdata(key: 'TOKEN').toString());
      CacheHelper.getdata(key: 'TOKEN') != null?
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeLayout())):
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => OnBoardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(child: ZoomIn(child: Image.asset('assets/images/logo.png')))
    );
  }
}
