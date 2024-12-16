import '../../../domain/entities/order/create_order/order_response_entity.dart';

sealed class OrderState {}
final class OrderInitialState extends OrderState {}

final class OrderLoadingState extends OrderState {}

//createOrder
final class CheckoutSuccessState extends OrderState {
  final OrderEntity? orderEntity;
  CheckoutSuccessState({required this.orderEntity});
}

final class CheckoutErrorState extends OrderState {
  final String? errorMessage;
  CheckoutErrorState({this.errorMessage});
}
//getAllOrders
final class GetOrdersSuccessState extends OrderState {
  final OrderEntity? orders;

  GetOrdersSuccessState({required this.orders});
}

final class GetOrdersErrorState extends OrderState {
  final String? errorMessage;
  GetOrdersErrorState({this.errorMessage});
}
