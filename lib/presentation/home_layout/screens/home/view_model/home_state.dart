part of 'home_view_model.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeDataLoading extends HomeState {}

final class HomeDataLoaded extends HomeState {
  final HomeData? homeData;

  HomeDataLoaded(this.homeData);
}

final class HomeDataError extends HomeState {
  final String? message;

  HomeDataError(this.message);
}
