import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/models/order/response/create_order_response/order_model.dart';
import '../../../../domain/entities/address/create_order/order_entity.dart';
import '../../../models/order/request/create_order_request/create_order_request.dart';
import '../../../models/order/response/address_models/address_response_model.dart';

abstract class OrderRemoteDataSource {
  Future<Result<OrderEntity?>> createOrder(
      CreateOrderRequest createOrderRequest);
  Future<Result<OrderModel?>> createOrder(CreateOrderRequest createOrderRequest);
}
