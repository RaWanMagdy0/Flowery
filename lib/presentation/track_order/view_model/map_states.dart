import '../../../../domain/entities/pending_orders/order_entity.dart';

sealed class PendingOrderState {}
class OrderStateInitial extends PendingOrderState {}

class OrderStateLoading extends PendingOrderState {}

//getAllPendingOrders
final class PendingGetOrdersSuccessState extends PendingOrderState {
  final List<OrderEntityDriver?> orders;

  PendingGetOrdersSuccessState({required this.orders});
}

final class PendingGetOrdersErrorState extends PendingOrderState {
  final String? errorMessage;

  PendingGetOrdersErrorState({this.errorMessage});
}

