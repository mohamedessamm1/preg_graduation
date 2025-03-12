import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Cache/local_cache.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';
import 'package:pregnant_care/core/shared/widget_shared/custom_button_widget.dart';
import 'package:pregnant_care/core/shared/widget_shared/custom_text_field.dart';

import '../manager/profule_cubit.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfuleCubit(),
      child: BlocBuilder<ProfuleCubit, ProfuleState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: mainColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  80.ph,
                  Container(
                    height: 650.h,
                    padding:  EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color:  Color(0xFFB38E74), // Background color
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
            
                      children: [
                        SizedBox(height: 10.h),
                        Text(
                          "Change Password",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "The password should have at least 6 characters.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black54,
                          ),
                        ),
                        40.ph,
                        Row(
                          children: [
                            Text('old password',style: TextStyle(color: Colors.brown.shade800,fontSize: 16.sp),),
                          ],
                        ),
                        8.ph,
            
                        CustomTextField(
                          controller: ProfuleCubit.get(context).oldPasswordController,
                            prefixIconColor: mainColor,
                            suffixIconColor: mainColor,
                            fillColor: Colors.white,
                            borderColor: Colors.white
                            , focusBorderColor: Colors.brown,
                            enabledBorderColor: mainColor
                        ),
                        25.ph,
                        Row(
                          children: [
                            Text('new password',style: TextStyle(color: Colors.brown.shade800,fontSize: 16.sp),),
                          ],
                        ),
                        8.ph,
                        CustomTextField(
                          controller: ProfuleCubit.get(context).newPasswordController,
                            prefixIconColor: mainColor,
                            suffixIconColor: mainColor,
                            fillColor: Colors.white,
                            borderColor: Colors.white
                            , focusBorderColor: Colors.brown,
                            enabledBorderColor: mainColor
                        ),          25.ph,
                        Row(
                          children: [
                            Text('confirm password',style: TextStyle(color: Colors.brown.shade800,fontSize: 16.sp),),
                          ],
                        ),
                        8.ph,
                        CustomTextField(
                          controller: ProfuleCubit.get(context).confirmPasswordController,
                            prefixIconColor: mainColor,
                            suffixIconColor: mainColor,
                            fillColor: Colors.white,
                            borderColor: Colors.white
                            , focusBorderColor: Colors.brown,
                            enabledBorderColor: mainColor
                        ),
                        100.ph,
                        state is LoadingEditProfileState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              ):

                        customButton(onTap: (){
                          print(ProfuleCubit.get(context).oldPasswordController.text);
                          print(ProfuleCubit.get(context).newPasswordController.text);
                          ProfuleCubit.get(context).updateUser(context: context);
                        }, text: 'save',),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
