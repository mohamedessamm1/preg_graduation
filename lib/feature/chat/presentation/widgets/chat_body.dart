import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared/Colors/colors.dart';
import '../manager/chat_cubit.dart';
import 'message_widget.dart';
import 'no_message_widget.dart';

Widget chatBodyWidget(
    {required context,
    required chatCubit,
    required groupName,
    required scrollController,
    required receiverEmail,
    required messageController,
    required receiverId}) {
  return Scaffold(
    backgroundColor: mainColor,
      appBar: AppBar(
        leading: IconButton(

            onPressed: () {
              ChatCubit.get(context).messageList = [];
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        backgroundColor: mainColor,
        title: Text(
          groupName==''?receiverEmail:'Group',
          style: TextStyle(fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: messageWidget(
          receiverEmail: receiverEmail,
            groupName: groupName,
            receiverId: receiverId,
            scrollController: scrollController,
            context: context,
            messageController: messageController, chatCubit: chatCubit)
      ));
}
