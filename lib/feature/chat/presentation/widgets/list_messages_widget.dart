import 'package:flutter/material.dart';
import 'package:pregnant_care/feature/chat/presentation/widgets/receive_message.dart';
import 'package:pregnant_care/feature/chat/presentation/widgets/send_message_widget.dart';
import '../../../../core/shared/Cache/local_cache.dart';

Widget listMessagesWidget({scrollController, context, chatCubit}) {
  return Expanded(
      child: ListView.builder(
    reverse: true,
    controller: scrollController,
    itemBuilder: (context, index) {
      return chatCubit.messageList[index]['sender'] ==
              CacheHelper.getdata(key: 'email').toString()
          ? sendMessage(chatCubit.messageList[index]['text'],
              DateTime.parse(chatCubit.messageList[index]['dateTime']),'${chatCubit.messageList[index]['sender']}')
          : receiveMessage(chatCubit.messageList[index]['text'],
              DateTime.parse(chatCubit.messageList[index]['dateTime']),'${chatCubit.messageList[index]['sender']}');
    },
    itemCount: chatCubit.messageList.length,
  ));
}
