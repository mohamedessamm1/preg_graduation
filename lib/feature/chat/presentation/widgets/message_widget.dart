import 'package:flutter/material.dart';
import 'package:pregnant_care/core/shared/extension/extencion.dart';
import '../../../../core/shared/Cache/local_cache.dart';
import '../manager/chat_cubit.dart';
import 'custom_textField.dart';
import 'list_messages_widget.dart';

Widget messageWidget({
  required BuildContext context,
  required ScrollController scrollController,
  required String groupName,
  required TextEditingController messageController,
  required String receiverId,
  required String receiverEmail,
  required ChatCubit chatCubit,
}) {
  return Column(
    children: [
      /// قائمة الرسائل
      Expanded(
        child: listMessagesWidget(
          context: context,
          chatCubit: chatCubit,
          scrollController: scrollController,
        ),
      ),

      /// إدخال الرسالة
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              /// حقل إدخال النص
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: const InputDecoration(
                    hintText: 'اكتب رسالتك...',
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      sendMessage(
                        chatCubit: chatCubit,
                        groupName: groupName,
                        receiverId: receiverId,
                        messageController: messageController,
                        scrollController: scrollController,
                      );
                    }
                  },
                ),
              ),

              /// زر الإرسال
              IconButton(
                icon: const Icon(Icons.send, color: Colors.blueAccent),
                onPressed: () {
                  if (messageController.text.trim().isNotEmpty) {
                    print(groupName);
                    groupName==''?
                    ChatCubit.get(context).sendMessageUser(
                        textFieldController: messageController,
                        scrollController: scrollController,
                        date: DateTime.now(),
                        sender: CacheHelper.getdata(key: 'email'),
                        text: messageController.text, receiverEmail: receiverEmail):

                    ChatCubit.get(context).sendMessage(
                        receiverId: receiverId,
                        groupName: groupName,
                        textFieldController: messageController,
                        scrollController: scrollController,
                        date: DateTime.now(),
                        sender: CacheHelper.getdata(key: 'email'),
                        text: messageController.text);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

/// دالة إرسال الرسالة
void sendMessage({
  required ChatCubit chatCubit,
  required String groupName,
  required String receiverId,
  required TextEditingController messageController,
  required ScrollController scrollController,
}) {
  chatCubit.sendMessage(
    groupName: groupName,
    receiverId: receiverId,
    textFieldController: messageController,
    scrollController: scrollController,
    date: DateTime.now(),
    sender: CacheHelper.getdata(key: 'email'),
    text: messageController.text.trim(),
  );
}
