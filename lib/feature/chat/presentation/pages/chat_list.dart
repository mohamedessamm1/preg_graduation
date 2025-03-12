import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';
import 'package:pregnant_care/feature/chat/presentation/pages/chat_screen2.dart';
import 'package:pregnant_care/feature/chat/presentation/pages/mom_group.dart';
import 'package:pregnant_care/feature/chat/presentation/pages/yoga.dart';

import '../manager/chat_cubit.dart';
import 'baby_name.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ChatCubit()..GetAllUsersData(),
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            var cubit = ChatCubit.get(context);
            return Scaffold(
              backgroundColor: mainColor,
              body: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Community',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Divider(
                      color: Colors.brown.shade300,
                    ),
                    Text(
                      'Groups',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => mom_screen(),
                                ));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30.r,
                                  backgroundImage: AssetImage(
                                      'assets/images/mom_group.png'),
                                ),
                                15.pw,
                                Text(
                                  'moms group',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BabyScreen(),
                                ));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30.r,
                                  backgroundImage: AssetImage(
                                      'assets/images/sleeping_baby.png'),  ),
                                15.pw,
                                Text(
                                  'baby names',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => YogaScreen(),
                                ));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30.r,
                                  backgroundImage: AssetImage(
                                      'assets/images/yoga.png')   ),
                                15.pw,
                                Text(
                                  'yoga & sports',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'chats',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown),
                    ),
                    IconButton(
                        onPressed: () {
                          ChatCubit.get(context).GetAllUsersData();
                        },
                        icon: Icon(Icons.abc)),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => SizedBox(
                          height: 80.h,
                          child: Card(
                            elevation: 2,
                            color: mainColor,
                            child: InkWell(
                              onTap: () {
                                // Navigator.push(context,MaterialPageRoute(builder: (context) => ChatsScreen2(uid: cubit.users[index].uid.toString()),));
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 30.r,
                                    backgroundImage:
                                        AssetImage('assets/images/user.png'),
                                  ),
                                  15.pw,
                                  Text(
                                    '${ChatCubit.get(context).users[index].name}',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) => 5.ph,
                        itemCount: ChatCubit.get(context).users.length,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
