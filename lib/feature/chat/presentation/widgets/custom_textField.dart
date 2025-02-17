import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customTextField(
        {bool showPassword = false,
        required hintText,
        required Widget suffixIcon,
        required TextEditingController controller,
        TextInputType keyBoardType = TextInputType.emailAddress,
        String validateName = ''}) =>
    SizedBox(
      width: double.infinity,
      height: 55.h,
      child: TextFormField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $validateName';
          }
          return null;
        },
        obscureText: showPassword,
        controller: controller,
        keyboardType: keyBoardType,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.brown),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade200)),
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.blue.shade700.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(8.r)),
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.r))),
      ),
    );
