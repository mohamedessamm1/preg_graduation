import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Cache/local_cache.dart';
import 'package:pregnant_care/core/shared/Dio/app_dio.dart';
import 'package:pregnant_care/feature/auth/login/presentation/pages/login_screen.dart';
import 'package:pregnant_care/feature/auth/register/presentation/pages/register_screen.dart';
import 'package:pregnant_care/feature/home/presentation/manager/home_cubit.dart';
import 'package:pregnant_care/feature/layout/presentation/manager/home_layout_cubit.dart';
import 'package:pregnant_care/feature/layout/presentation/pages/HomeLayout.dart';

import 'feature/auth/otp/presentation/pages/opt_screen.dart';
import 'feature/splash_screen/presentation/pages/splash_screen_timer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  CacheHelper.initcache();
  AppDioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()..fetchMyData()..getCourses(),
        ),
        BlocProvider(
          create: (context) => HomeLayoutCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(440, 956),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, screenUtil) {
          return MaterialApp(
              theme: ThemeData(
                  progressIndicatorTheme: ProgressIndicatorThemeData(
                      color: Colors.brown.shade700)),
              debugShowCheckedModeBanner: false, home: SplashView());
        },
      ),
    );
  }
}
