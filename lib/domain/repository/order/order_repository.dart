import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/entities/address/saved_addresses_entity.dart';

import '../../../data/models/order/request/create_order_request/create_order_request.dart';
import '../../../data/models/order/response/address_models/address_response_model.dart';
import '../../entities/address/create_order/order_entity.dart';

abstract class OrderRepository {
  Future<Result<OrderEntity?>> createOrder(
      CreateOrderRequest createOrderRequest);
}
