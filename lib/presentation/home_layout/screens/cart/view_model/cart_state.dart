part of 'cart_view_model_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class NoUserLogged extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<CartProduct>? data;
  CartLoaded(this.data);
}

final class CartEmpty extends CartState {}

final class CartError extends CartState {
  final String errorMessage;

  CartError(this.errorMessage);
}
