import 'package:flutter/material.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';
import '../../../../core/shared/Cache/local_cache.dart';
import '../../manager/chat_cubit.dart';
import 'custom_textField.dart';
import 'list_messages_widget.dart';

Widget messageWidget(
    {required context,
    required scrollController,
    required groupName,
    required messageController,
    receiverId,
    required chatCubit}) {
  return Column(
    children: [
      listMessagesWidget(
          context: context,
          chatCubit: chatCubit,
          scrollController: scrollController),
      14.ph,
      customTextField(
          validateName: '',
          hintText: 'اكتب رسالتك',
          suffixIcon: IconButton(
              onPressed: () {
                ChatCubit.get(context).sendMessage(
                  groupName: groupName,
                    receiverId: receiverId,
                    textFieldController: messageController,
                    scrollController: scrollController,
                    date: DateTime.now(),
                    sender: CacheHelper.getdata(key: 'email'),
                    text: messageController.text);
              },
              icon: const Icon(Icons.send)),
          controller: messageController),
      12.ph
    ],
  );
}
