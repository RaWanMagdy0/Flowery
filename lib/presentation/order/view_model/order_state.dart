import '../../../domain/entities/order/create_order/order_entity.dart';

sealed class OrderState {}
final class OrderInitialState extends OrderState {}

final class CheckoutLoadingState extends OrderState {}

final class CheckoutSuccessState extends OrderState {
  final OrderEntity? orderEntity;
  CheckoutSuccessState({required this.orderEntity});
}

final class CheckoutErrorState extends OrderState {
  final String? errorMessage;
  CheckoutErrorState({this.errorMessage});
}
