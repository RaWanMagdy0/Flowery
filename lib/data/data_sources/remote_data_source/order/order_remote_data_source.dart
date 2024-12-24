import 'package:flowery/core/api/api_result.dart';
import '../../../models/order/request/create_order_request/create_order_request.dart';
import '../../../models/order/response/create_order_response/order_response_model.dart';

abstract class OrderRemoteDataSource {
  Future<Result<OrderModel?>> createOrder(CreateOrderRequest createOrderRequest);
  Future<Result<OrderModel?>> getOrdersHistory();


}
