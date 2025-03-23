import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/feature/chat/presentation/pages/chat_screen2.dart';
import '../../../../core/shared/Cache/local_cache.dart';
import '../manager/chat_cubit.dart';
import 'baby_name.dart';
import 'mom_group.dart';
import 'yoga.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..GetAllUsersData()..getMyDataFireStore(),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          var cubit = ChatCubit.get(context);
          return Scaffold(
            backgroundColor: mainColor,
            appBar: AppBar(
              title: Text(
                'Community',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
            body: ConditionalBuilder(condition: cubit.users.isNotEmpty, builder: (context) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Groups',
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildGroupItem(context, 'Moms Group', 'assets/images/mom_group.png', MomGroupScreen()),
                          _buildGroupItem(context, 'Baby Names', 'assets/images/sleeping_baby.png', BabyScreen()),
                          _buildGroupItem(context, 'Yoga & Sports', 'assets/images/yoga.png', YogaScreen()),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Chats',
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 10.h),

                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return cubit.users[index].email==CacheHelper.getdata(key: 'email')?SizedBox():
                          _buildChatItem(context, cubit.users[index].name!,
                              cubit.users[index].uid,
                              cubit.users[index].email,
                              cubit.users[index].dr


                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(height: 25.h),
                        itemCount: cubit.users.length,
                      ),
                    ],
                  ),
                ),
              );
            }, fallback: (context) => Center(child: CircularProgressIndicator()))
          );
        },
      ),
    );
  }

  Widget _buildGroupItem(BuildContext context, String title, String image, Widget page) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30.r,
            backgroundImage: AssetImage(image),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, String name , String? uid, String? email,dr) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatsScreen2(
          email: email,
          name: name,
          uid: uid,
        ),));
      },
      child: Container(
        decoration: BoxDecoration(
          color: mainColor, // تغيير لون الكارت إلى البني الداكن
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // إضافة ظل خفيف
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 27.r,
            backgroundImage: dr==true?AssetImage('assets/images/dr.png'): AssetImage('assets/images/user.png'),
          ),
          title: Text(
            name,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
