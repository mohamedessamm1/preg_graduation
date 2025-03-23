import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Cache/local_cache.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';
import 'package:pregnant_care/core/shared/widget_shared/custom_text_field.dart';
import 'package:pregnant_care/feature/profile/presentation/manager/profule_cubit.dart';

import '../../../../core/shared/constant.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfuleCubit()..fetchMyData(),
        child:
            BlocBuilder<ProfuleCubit, ProfuleState>(builder: (context, state) {
          return Scaffold(
              backgroundColor: mainColor, // Dark background
              appBar: AppBar(
                title: const Text("Edit profile",
                    style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: ConditionalBuilder(
                  condition: state is! FetchMyDataLoadingState,
                  builder: (context) => SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        35.ph,
                        Padding(
                          padding: EdgeInsets.all(16.0.w),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 25),
                            decoration: BoxDecoration(
                              color: const Color(0xFFB08E76), // Brownish color
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                15.ph,
                                CircleAvatar(
                                  radius: 40.r,
                                  backgroundImage: AssetImage(
                                      "assets/images/user.png"), // Replace with actual image
                                ),
                                10.ph,
                                Text(
                                  accountModel?.username ?? "",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),

                                20.ph,
                                Row(
                                  children: [
                                    Text('Full Name',style: TextStyle(color: Colors.white,fontSize: 16.sp),),
                                  ],
                                ),
                                CustomTextField(
                                    controller: ProfuleCubit.get(context).nameController,
                                    prefixIconColor: mainColor,
                                    suffixIconColor: mainColor,
                                    fillColor: mainColor,
                                    borderColor: mainColor,
                                    focusBorderColor: Colors.white,
                                    enabledBorderColor: mainColor),

                                SizedBox(height: 20.h),
                                Row(
                                  children: [
                                    Text('Email',style: TextStyle(color: Colors.white,fontSize: 16.sp),),
                                  ],
                                ),
                                CustomTextField(
                                    controller: ProfuleCubit.get(context).emailController,
                                    prefixIconColor: mainColor,
                                    suffixIconColor: mainColor,
                                    fillColor: mainColor,
                                    borderColor: mainColor,
                                    focusBorderColor: Colors.white,
                                    enabledBorderColor: mainColor
                                ),
                                30.ph,
                                state is LoadingEditProfileState
                                    ? CircularProgressIndicator(color: Colors.brown,) :


                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.brown,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 60.w, vertical: 12.h),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                  ),
                                  onPressed: () async{
                                   await ProfuleCubit.get(context).editProfile(context: context);
                                   await ProfuleCubit.get(context).fetchMyData();
                                  },
                                  child: Text("Edit",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.sp)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  fallback: (context) => const Center(child: CircularProgressIndicator())),);
        }));
  }
}
