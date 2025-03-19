import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';

import '../../../chat/presentation/manager/chat_cubit.dart';
import '../../../chat/presentation/pages/baby_name.dart';
import '../../../chat/presentation/pages/mom_group.dart';
import '../../../chat/presentation/pages/yoga.dart';


class GroupCommunityScreen extends StatelessWidget {
  const GroupCommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..GetAllUsersData()..getMyDataFireStore(),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: mainColor,
            appBar: AppBar(
              title: Text(
                'My Groups',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Column(
                  spacing:  25.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 10.h),
                    _buildGroupItem(context, 'Moms Group', 'assets/images/mom_group.png', MomGroupScreen()),
                    _buildGroupItem(context, 'Baby Names', 'assets/images/sleeping_baby.png', BabyScreen()),
                    _buildGroupItem(context, 'Yoga & Sports', 'assets/images/yoga.png', YogaScreen()),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGroupItem(BuildContext context, String title, String image, Widget page) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 34.r,
            backgroundImage: AssetImage(image),
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

}
