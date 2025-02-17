part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class FavoritePressState extends HomeState {}
final class SearchState extends HomeState {}
