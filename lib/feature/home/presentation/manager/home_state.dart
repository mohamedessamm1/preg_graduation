part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class FavoritePressState extends HomeState {}
final class SearchState extends HomeState {}
final class FetchMyDataLoadingState extends HomeState {}
final class FetchMyDataSuccessState extends HomeState {}
final class FetchMyDataErrorState extends HomeState {}
final class SuccessSendMessageState extends HomeState {}
final class ErrorSendMessageState extends HomeState {}
