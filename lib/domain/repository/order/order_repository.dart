import '../../../core/api/api_result.dart';
import '../../../data/models/order/request/create_order_request/create_order_request.dart';
import '../../entities/order/create_order/order_response_entity.dart';

abstract class OrderRepository {
  Future<Result<OrderEntity?>> createOrder(
      CreateOrderRequest createOrderRequest);
  Future<Result<OrderEntity>> getOrdersHistory();

}
