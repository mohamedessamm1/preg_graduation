import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Colors/colors.dart';

Widget dropDownWidget(
    {required context,
    required List<DropdownMenuItem<String>>? items,
    var value,
    onchanged}) {
  {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.transparent),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: DropdownButton<String>(
            iconEnabledColor: mainColor,
            underline: Container(),
            borderRadius: BorderRadius.circular(10.r),
            value: value,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down_sharp),
            elevation: 16,
            style: TextStyle(
                color: mainColor, fontSize: 14.sp, fontWeight: FontWeight.w500),
            onChanged: (String? value) {
              onchanged.dropDownChange(value);
            },
            items: items),
      ),
    );
  }
}
