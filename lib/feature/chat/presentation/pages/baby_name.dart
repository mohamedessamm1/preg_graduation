import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/chat_cubit.dart';
import '../widgets/chat_body.dart';

class BabyScreen extends StatelessWidget {
  const BabyScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ChatCubit(),
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            ChatCubit.get(context).getMessage(ReceiverId: '1',groupName: 'group2');
            return chatBodyWidget(
              receiverEmail:'',
                receiverId: '1',
                groupName: 'group2',
                context: context,
                chatCubit: ChatCubit.get(context),
                scrollController: ChatCubit.get(context).scrollController,
                messageController: ChatCubit.get(context).messageController);
          },
        ));
  }
}
