import 'package:flowery/core/api/api_result.dart';
import '../../../../domain/entities/address/create_order/order_entity.dart';
import '../../../models/order/request/create_order_request/create_order_request.dart';

abstract class OrderRemoteDataSource {
  Future<Result<OrderEntity?>> createOrder(CreateOrderRequest createOrderRequest);
}
