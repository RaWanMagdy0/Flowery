import 'package:flowery/core/api/api_result.dart';

import 'package:flowery/data/models/payment/response/credit_payment_response_model.dart';
import '../../../models/order/request/create_order_request/create_order_request.dart';
import '../../../models/order/response/create_order_response/order_response_model.dart';
import '../../../models/payment/request/payment_request_model.dart';

abstract class OrderRemoteDataSource {
  Future<Result<OrderModell?>> createOrder(
      CreateOrderRequest createOrderRequest);

  Future<Result<OrderModell?>> getOrdersHistory();

  Future<Result<OrderModell?>> cashPaymentMethod(
      ShippingAddressRequest shippingAddressRequest);

  Future<Result<CreditPaymentResponseModel?>> creditCardPaymentMethod(
      ShippingAddressRequest shippingAddressRequest);
}
