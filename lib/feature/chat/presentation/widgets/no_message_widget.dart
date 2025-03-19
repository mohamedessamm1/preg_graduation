// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../core/shared/Cache/local_cache.dart';
// import '../manager/chat_cubit.dart';
// import 'custom_textField.dart';
//
// Widget noMessageWidget(
//     {context, messageController, scrollController, receiverId ,groupName}) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.end,
//     children: [
//       const Text(''),
//       Center(
//         child: Padding(
//           padding: EdgeInsets.all(12.0.w),
//           child: customTextField(
//               validateName: '',
//               hintText: 'اكتب رس55555التك',
//               suffixIcon: IconButton(
//                   onPressed: () {
//                     print(groupName);
//                     groupName==null?
//                     ChatCubit.get(context).sendMessageUser(
//                         receiverId: receiverId,
//                         textFieldController: messageController,
//                         scrollController: scrollController,
//                         date: DateTime.now(),
//                         sender: CacheHelper.getdata(key: 'email'),
//                         text: messageController.text):
//
//                     ChatCubit.get(context).sendMessage(
//                         receiverId: receiverId,
//                         groupName: groupName,
//                         textFieldController: messageController,
//                         scrollController: scrollController,
//                         date: DateTime.now(),
//                         sender: CacheHelper.getdata(key: 'email'),
//                         text: messageController.text);
//                   },
//                   icon: const Icon(Icons.send)),
//               controller: messageController),
//         ),
//       )
//     ],
//   );
// }
