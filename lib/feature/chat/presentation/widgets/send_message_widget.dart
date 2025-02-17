import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';

Widget sendMessage(message, DateTime time,sender) {
  return Align(
    alignment: AlignmentDirectional.bottomEnd,
    child: Padding(
        padding: EdgeInsets.only(left: 40.w, top: 5.h),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.all(Radius.circular(8.r))),
            child: Padding(
                padding: EdgeInsets.all(11.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '$sender'
                            ,style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w500,color: Colors.grey.shade400),
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            ' $message ',
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                        8.pw,
                        Text(
                          DateFormat('hh:mm a').format(time),
                          style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                )))),
  );
}

