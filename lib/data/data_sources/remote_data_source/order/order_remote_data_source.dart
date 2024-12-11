import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/models/order/response/create_order_response/order_item_model.dart';
import 'package:flowery/data/models/order/response/create_order_response/order_model.dart';
import '../../../models/order/request/create_order_request/create_order_request.dart';

abstract class OrderRemoteDataSource {
  Future<Result<OrderModel?>> createOrder(CreateOrderRequest createOrderRequest);
  Future<Result<OrderModel?>> getOrdersHistory();
}
