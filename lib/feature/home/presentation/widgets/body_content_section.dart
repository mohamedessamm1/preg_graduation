import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyContentSection extends StatelessWidget {
  String title;
  String content;
  BodyContentSection({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
            color: Color(0xFFFFFFFF),
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 350.w,
          child: Text(
            content,
            style: TextStyle(
              fontSize: 12.sp,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'Video Tips',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
            color: Color(0xFFFFFFFF),
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
