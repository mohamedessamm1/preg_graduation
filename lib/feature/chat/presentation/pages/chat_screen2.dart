import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/feature/chat/presentation/widgets/chat_body.dart';
import '../../../../core/shared/Cache/local_cache.dart';
import '../../../../core/shared/constant.dart';
import '../../model/models/message_model.dart';
import '../manager/chat_cubit.dart';

class ChatsScreen2 extends StatelessWidget {
  String? uid;
  String? name;
  String? email;

  ChatsScreen2({
    this.uid,
    this.name,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          ChatCubit.get(context).getMessageUser(ReceiverId: email);

          final double itemsize = 100;
          return Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: mainColor,
              body: chatBodyWidget(
                receiverEmail:email ,
                  context: context,
                  chatCubit: ChatCubit.get(context),
                  groupName: '',
                  scrollController: ChatCubit.get(context).scrollController,
                  messageController: ChatCubit.get(context).messageController,
                  receiverId: uid));
        },
      ),
    );
  }
}

Widget sendmessage(MessageModel messageModel) {
  return Align(
    alignment: AlignmentDirectional.bottomStart,
    child: Padding(
      padding: EdgeInsets.only(left: 10.w, top: 10.h),
      child: Container(
        width: 230.w,
        decoration: BoxDecoration(
            color: Colors.blue.shade900.withOpacity(0.4),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
              topLeft: Radius.circular(15.r),
            )),
        child: Center(
            child: Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Text(
                  '${messageModel.text}',
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ))),
      ),
    ),
  );
}

Widget receivemessage(var message) {
  return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: Padding(
        padding: EdgeInsets.only(right: 10.w, top: 10.h),
        child: Container(
          width: 230.w,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r),
                topLeft: Radius.circular(15.r),
              )),
          child: Center(
              child: Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: Text(
                    '${message.text}',
                    style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ))),
        ),
      ));
}
