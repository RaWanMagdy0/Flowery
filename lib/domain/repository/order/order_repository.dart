import 'package:flowery/core/api/api_result.dart';
import '../../../data/models/order/request/create_order_request/create_order_request.dart';
import '../../../data/models/order/response/create_order_response/order_model.dart';
import '../../entities/order/create_order/order_entity.dart';
import '../../entities/order/create_order/order_item_entity.dart';

abstract class OrderRepository {
  Future<Result<OrderEntity?>> createOrder(
      CreateOrderRequest createOrderRequest);
  Future<Result<OrderEntity?>> getOrdersHistory();

}
