import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared/Colors/colors.dart';
import 'message_widget.dart';
import 'no_message_widget.dart';

Widget chatBodyWidget(
    {required context,
    required chatCubit,
    required groupName,
    required scrollController,
    required messageController,
    required receiverId}) {
  return Scaffold(
    backgroundColor: mainColor,
appBar: AppBar(
  backgroundColor: mainColor,
),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: chatCubit.messageList.isEmpty
            ? noMessageWidget(
          groupName: groupName,
                receiverId: receiverId,
                scrollController: scrollController,
                context: context,
                messageController: messageController)
            : messageWidget(
          groupName:groupName ,
                receiverId: receiverId,
                context: context,
                scrollController: scrollController,
                messageController: messageController,
                chatCubit: chatCubit),
      ));
}
