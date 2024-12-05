import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/entities/address/create_order/order.dart';

import '../../../data/models/order/request/create_order_request/create_order_request.dart';

abstract class OrderRepository{
Future<Result<OrderEntity?>>createOrder(CreateOrderRequest createOrderRequest);
}