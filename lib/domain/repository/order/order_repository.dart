import '../../../core/api/api_result.dart';
import '../../../data/models/order/request/create_order_request/create_order_request.dart';
import '../../entities/address/create_order/order.dart';

abstract class OrderRepository {
  Future<Result<OrderEntity?>> createOrder(
      CreateOrderRequest createOrderRequest);
}
