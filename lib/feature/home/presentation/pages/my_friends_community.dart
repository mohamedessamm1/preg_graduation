import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/feature/chat/presentation/pages/chat_screen2.dart';
import '../../../../core/shared/Cache/local_cache.dart';
import '../../../chat/presentation/manager/chat_cubit.dart';

class ChatListCommunityScreen extends StatelessWidget {
  const ChatListCommunityScreen({super.key});


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
                'Friends',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
            body: ConditionalBuilder(condition: cubit.users.isNotEmpty, builder: (context) {
            return  Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: cubit.users.length,
                  itemBuilder: (context, index) {
                    var user = cubit.users[index];
                    if (user.email == CacheHelper.getdata(key: 'email')) {
                      return SizedBox();
                    }
                    return _buildChatItem(context, user.name!, user.uid, user.email, user.dr??false);
                  },
                ),
              );
            }, fallback: (context) => Center(child: CircularProgressIndicator())),
          );
        },
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, String name, String? uid, String? email, bool dr) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatsScreen2(email: email, name: name, uid: uid),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30.r,
            backgroundImage: AssetImage(dr ? 'assets/images/dr.png' : 'assets/images/user.png'),
          ),
          title: Text(
            name,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}