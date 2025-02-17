import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Colors/colors.dart';

Widget switchLoginSignInWidget({currentScreen, required Function() onTap}) {
  return currentScreen == 'login'
      ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Didn’t have any account?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                )),
            InkWell(
              onTap: onTap,
              child: Text(' Sign Up',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.brown,
                    textBaseline: TextBaseline.ideographic,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  )),
            ),
          ],
        )
      : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Already have any account? ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                )),
            InkWell(
              onTap: onTap,
              child: Text('Login',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.brown,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  )),
            ),
          ],
        );
}
