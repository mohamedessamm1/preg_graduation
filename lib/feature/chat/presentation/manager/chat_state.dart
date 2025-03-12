part of 'chat_cubit.dart';

abstract class ChatState {}

final class ChatInitial extends ChatState {}

final class SuccessSendMessageState extends ChatState {}

final class ErrorSendMessageState extends ChatState {}

final class SuccessGetMessageState extends ChatState {}
final class GetAllUsersDataLoadingState extends ChatState {}
final class GetAllUsersDataState extends ChatState {}
final class GetAllUsersDataErrorState extends ChatState {}
