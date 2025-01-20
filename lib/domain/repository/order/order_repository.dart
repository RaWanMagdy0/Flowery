import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/entities/order/create_order/order_entity.dart';
import 'package:flowery/domain/entities/order/payment/credit_card_entity.dart';
import '../../../data/models/order/request/create_order_request/create_order_request.dart';
import '../../../data/models/payment/request/payment_request_model.dart';

abstract class OrderRepository {
  Future<Result<OrderEntity?>> createOrder(
      CreateOrderRequest createOrderRequest);

  Future<Result<List<OrderEntity?>>> getOrdersHistory();

  Future<Result<OrderEntity?>> cashPaymentMethod(
      ShippingAddressRequest shippingAddressRequest);

  Future<Result<CreditPaymentEntity?>> creditCardPaymentMethod(
      ShippingAddressRequest shippingAddressRequest);
}
