import 'package:flowery/domain/entities/order/payment/credit_card_entity.dart';

import '../../../core/api/api_result.dart';
import '../../../data/models/order/request/create_order_request/create_order_request.dart';
import '../../../data/models/payment/request/payment_request_model.dart';
import '../../entities/order/create_order/order_response_entity.dart';

abstract class OrderRepository {
  Future<Result<OrderEntity?>> createOrder(
      CreateOrderRequest createOrderRequest);

  Future<Result<OrderEntity>> getOrdersHistory();

  Future<Result<OrderEntity?>> cashPaymentMethod(
      ShippingAddressRequest shippingAddressRequest);

  Future<Result<CreditPaymentEntity?>> creditCardPaymentMethod(
      ShippingAddressRequest shippingAddressRequest);
}
