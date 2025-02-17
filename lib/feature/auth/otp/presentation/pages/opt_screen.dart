import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:pinput/pinput.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';

import '../../../../../core/shared/widget_shared/custom_button_widget.dart';

class OptScreen extends StatelessWidget {
  final String email;
  const OptScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                140.ph,
                Text(
                  'otp verification ',
                  style: TextStyle(
                      color: Colors.brown,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold),
                ),

                10.ph,
                Text(
                  'we have sent a code to $email',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                70.ph,
                Pinput(
                  length: 4,
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  toolbarEnabled: true,
                  onCompleted: (pin) => print(pin),
                ),
                10.ph,
                Row(
                  children: [
                    Spacer(),
                    Text(
                      'resend at',
                      style: TextStyle(
                          color: Colors.brown,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(
                      flex: 4,
                    ),
                    Text(
                      '00:00',
                      style: TextStyle(
                          color: Colors.brown,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ],
                ),
                30.ph,
                TimerCountdown(
                  enableDescriptions: false,
                  format: CountDownTimerFormat.minutesSeconds,
                  spacerWidth: 10,
                  endTime: DateTime.now().add(
                    Duration(
                      minutes: 2,
                      seconds: 0,
                    ),
                  ),
                  onEnd: () {
                    print("Timer finished");
                  },
                ),
                20.ph
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: mainColor,
          height: 80.h,
          width: double.infinity,
          child:
          Column(
            children: [
              customButton(
                onTap: () {},
                text: 'verify',
                color: Colors.brown,
              ),
            ],
          ),
      ),

    );
  }
}
