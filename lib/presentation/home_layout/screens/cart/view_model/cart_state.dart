part of 'cart_view_model_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class NoUserLogged extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final Cart? data;
  CartLoaded(this.data);
}

final class CartEmpty extends CartState {}

final class CartError extends CartState {
  final String errorMessage;

  CartError(this.errorMessage);
}

final class AddToCartLoading extends CartState {}

final class AddToCartSuccess extends CartState {}

final class AddToCartError extends CartState {
  final String errorMessage;

  AddToCartError(this.errorMessage);
}
