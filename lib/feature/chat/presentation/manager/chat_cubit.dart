import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/Cache/local_cache.dart';
import '../../../../core/shared/constant.dart';
import '../../../auth/register/data/models/create_user_model.dart';
import '../../model/models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get(context) => BlocProvider.of(context);
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  String ? myUidFireStore;
  getMyDataFireStore() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getdata(key: 'TOKEN').toString())
        .get()
        .then((value) {
          print(CacheHelper.getdata(key: 'email').toString());
          print(value.data());
      myUidFireStore = value.data()?['uid'];
      print("myUidFireStore=>${myUidFireStore}");
    });
  }

  sendMessage(
      {required date,
      required text,
      required sender,
      required textFieldController,
      required receiverId,
      required groupName,
      required scrollController}) async {
    MessageModel messageModel =
        MessageModel(dateTime: date.toString(), sender: sender, text: text);
    await FirebaseFirestore.instance
        .collection('users')
        .doc('$groupName')
        .collection('chat')
        .doc(receiverId)
        .collection('message')
        .add(messageModel.toJson())
        .then((value) async {
      textFieldController.clear();
      groupName==''?
      getMessageUser(ReceiverId: receiverId):
      getMessage(ReceiverId: receiverId,groupName: groupName);
      Timer(
          const Duration(milliseconds: 300),
          () => scrollController
              .jumpTo(scrollController.position.minScrollExtent));
      emit(SuccessSendMessageState());
    }).catchError((Error) {
      emit(ErrorSendMessageState());
    });
  }


  List messageList = [];

  Future<List> getMessage({required ReceiverId, required groupName}) async {
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc('$groupName')
        .collection('chat')
        .doc(ReceiverId)
        .collection('message');

    try {
      // Fetch the snapshot of documents in the collection
      QuerySnapshot snapshot =
          await collectionRef.orderBy('dateTime', descending: true).get();

      // Convert each document in the snapshot to a Map and add it to a list
      messageList = snapshot.docs.map((doc) => doc.data()).toList();
      emit(SuccessGetMessageState());
      return messageList;
    } catch (e) {
      return [];
    }
  }
  @override
  Future<void> close() {
    messageController.dispose();
    scrollController.dispose();

    return super.close();
  }



  sendMessageUser(
      {required date,
        required text,
        required sender,
        required textFieldController,
        required receiverEmail,
        required scrollController}) async {
    MessageModel messageModel =
    MessageModel(dateTime: date.toString(), sender: sender, text: text);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getdata(key: 'email').toString())
        .collection('chat')
        .doc(receiverEmail)
        .collection('message')
        .add(messageModel.toJson());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverEmail)
        .collection('chat')
        .doc(CacheHelper.getdata(key: 'email').toString())
        .collection('message')
        .add(messageModel.toJson())
        .then((value) async {
          print(value.id);
          print(value.id);
      textFieldController.clear();

      getMessageUser(ReceiverId: receiverEmail);

      Timer(
          const Duration(milliseconds: 300),
              () => scrollController
              .jumpTo(scrollController.position.minScrollExtent));
      emit(SuccessSendMessageState());
    }).catchError((Error) {
      emit(ErrorSendMessageState());
    });
  }
  Future<List> getMessageUser({required ReceiverId}) async {
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getdata(key: 'email').toString())
        .collection('chat')
        .doc(ReceiverId)
        .collection('message');

    try {
      // Fetch the snapshot of documents in the collection
      QuerySnapshot snapshot =
      await collectionRef.orderBy('dateTime', descending: true).get();

      // Convert each document in the snapshot to a Map and add it to a list
      messageList = snapshot.docs.map((doc) => doc.data()).toList();
      emit(SuccessGetMessageState());
      return messageList;
    } catch (e) {
      return [];
    }
  }
  List<CreateUserModel> users = [];

  GetAllUsersData() {
    emit((GetAllUsersDataLoadingState()));
    users.clear();
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        users.add(CreateUserModel.fromjson(element.data()));
print(element.data());
      });
      emit((GetAllUsersDataState()));
    }).catchError((error) {
      print(error.toString());
      emit((GetAllUsersDataErrorState()));
    });
  }

}
