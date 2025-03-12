
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import '../../../../core/shared/Cache/local_cache.dart';
import '../../../../core/shared/constant.dart';
import '../../model/models/message_model.dart';
import '../manager/chat_cubit.dart';
class ChatsScreen2 extends StatelessWidget {
  String? uid;
  String? name;

  ChatsScreen2({
    this.uid,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:  (context) => ChatCubit(),
    child:  BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
      ChatCubit.get(context).getMessageUser(ReceiverId: uid);
      var TextControl = TextEditingController();
      ScrollController scrollController = ScrollController();
      final double itemsize = 100;
      return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: mainColor,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  ChatCubit.get(context).messageList = [];
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios)),
            backgroundColor:mainColor,
            title: Row(
              children: [

                SizedBox(
                  width: 20.w,
                ),
                Text(
                  '',
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            ),
            centerTitle: true,
          ),
          body: ConditionalBuilder(
              condition: true,
              builder: (context) => Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        controller:
                        ChatCubit.get(context).scrollController,
                        cacheExtent: itemsize,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              if (userModel?.uid ==
                                  ChatCubit.get(context)
                                      .messageList[index]['sender']) ...{
                                sendmessage(ChatCubit.get(context)
                                    .messageList[index]),
                              } else ...{
                                receivemessage(ChatCubit.get(context)
                                    .messageList[index]),
                              },
                            ],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(),
                        itemCount:
                        ChatCubit.get(context).messageList.length),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(left: 15.w, right: 10.w),
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.white),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: TextControl,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(30.r),
                                    borderSide: BorderSide(
                                        color: Colors
                                            .transparent), //<-- SEE HERE
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(30.r),
                                    borderSide: BorderSide(
                                        color: Colors
                                            .transparent), //<-- SEE HERE
                                  ),
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  filled: true),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                ChatCubit.get(context).sendMessageUser(
                                  textFieldController: TextControl,
                                  scrollController: scrollController,
                                  date:DateTime.now().toString(),
                                  text: TextControl.text,
                                  receiverId: uid,
                                  sender: CacheHelper.getdata(key: 'email'),


                                );

                                // AppCubit.get(context).getScroll();
                                // FocusManager.instance.primaryFocus?.unfocus();
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.blue.shade700,
                              )),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
              fallback: (context) => Center(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue.shade900,
                  ),
                ),
              )));
    },),
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
                )
        )),
      ),
    ),
  );
}

Widget receivemessage(MessageModel messageModel) {
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
              '${messageModel.text}',
              style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          )),
        ),
      ));
}
