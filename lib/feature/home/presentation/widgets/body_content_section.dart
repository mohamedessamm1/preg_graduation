import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class  BodyContentSection extends StatelessWidget {
  String title;
  String content;
    BodyContentSection({super.key,required this.title,required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
crossAxisAlignment: CrossAxisAlignment.start,

children: [
  Text(
    title,
  style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Color(0xFFFFFFFF),
  ),
),
  SizedBox(height: 8),
  SizedBox(
    width: 350.w,
    child: Text(
      content,
      style: TextStyle(
        fontSize: 14,
        color: Color(0xFFFFFFFF),
      ),
    ),
  ),
  SizedBox(height: 16),
  Text(
    'Video Tips',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Color(0xFFFFFFFF),
    ),
  ),
  SizedBox(height: 8),

],    );
  }
}
