import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';

import '../Colors/colors.dart';

Widget customButton({required Function() onTap, required String text, icon
,Color ? color = mainColor
}) {
  return InkWell(
    onTap: onTap,
    child: SizedBox(
      width: 340.w,
      height: 55.h,
      child: Card(
        color: color,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              icon == null
                  ? SizedBox()
                  : Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Icon(icon,color: Colors.white,size: 18.w,),
                  )
            ],
          ),
        ),
      ),
    ),
  );
}
