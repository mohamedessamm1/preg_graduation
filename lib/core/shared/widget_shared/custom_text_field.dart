import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final Color prefixIconColor;
  final Color suffixIconColor;
  final Color focusBorderColor;
  final Color enabledBorderColor;
  final Color borderColor;
  final TextInputAction? textInputAction;
  final FormFieldValidator? validator;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function()? suffixTab;
  final bool obscureText;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final Iterable<String>? autofillHints;
  final double? verticalPadding;
  final AutovalidateMode? autovalidateMode;
  final Color? fillColor;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.textInputAction,
    this.validator,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixTab,
    this.obscureText = false,
    this.maxLength,
    this.onChanged,
    this.autofillHints,
    this.verticalPadding,
    this.autovalidateMode,
    required this.prefixIconColor,
    required this.suffixIconColor,
    required this.fillColor,
    required this.borderColor,
    required this.focusBorderColor,
    required this.enabledBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      maxLines: keyboardType == TextInputType.multiline ? 6 : 1,
      minLines: 1,
      maxLength: maxLength,
      autofillHints: autofillHints,
      autovalidateMode: autovalidateMode,
      style: const TextStyle(fontWeight: FontWeight.w500),
      // onTapOutside: (event) {
      //   FocusManager.instance.primaryFocus!.unfocus();
      // },
      decoration: InputDecoration(
        fillColor:fillColor ,
        filled: true,
        labelText: labelText,
        contentPadding: EdgeInsetsDirectional.symmetric(
          vertical: verticalPadding ?? 12.0.sp,
          horizontal: 16.0.sp,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
            color: Colors.grey, fontSize: 16.sp, fontWeight: FontWeight.w400),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: prefixIconColor,
                size: 17.5.sp,
              )
            : null,
        suffixIcon: (suffixIcon != null)
            ? GestureDetector(
                onTap: suffixTab,
                child: Icon(
                  suffixIcon,
                  color: suffixIconColor,
                  size: 21.0.sp,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.r),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.r),
          borderSide: BorderSide(color: focusBorderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.r),
          borderSide: BorderSide(color: enabledBorderColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.r),
          borderSide: BorderSide(color: borderColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.r),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
