part of 'profule_cubit.dart';

@immutable
sealed class ProfuleState {}

final class ProfuleInitial extends ProfuleState {}
final class SuccessEditProfileState extends ProfuleState {}
final class LoadingEditProfileState extends ProfuleState {}
final class SuccessChangePasswordState extends ProfuleState {}
final class LoadingEditPassProfileState extends ProfuleState {}
final class FailureEditProfileState extends ProfuleState {}
final class FetchMyDataLoadingState extends ProfuleState {}
final class FetchMyDataSuccessState extends ProfuleState {}
final class FetchMyDataErrorState extends ProfuleState {}
