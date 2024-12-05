import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/entities/address/create_order/order.dart';
import '../../../../domain/entities/address/create_order/Order.dart';
import '../../../models/order/request/create_order_request/create_order_request.dart';

abstract class OrderRemoteDataSource {
  Future<Result<OrderEntity?>> createOrder(CreateOrderRequest createOrderRequest);
}
