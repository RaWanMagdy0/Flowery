import 'package:flowery/core/api/api_result.dart';
import '../../../models/order/request/create_order_request/create_order_request.dart';
import '../../../models/order/response/create_order/order_model.dart';
import '../../../models/payment/request/payment_request_model.dart';
import '../../../models/payment/response/credit_payment_response_model.dart';

abstract class OrderRemoteDataSource {
  Future<Result<OrderModel?>> createOrder(CreateOrderRequest createOrderRequest);
  Future<Result<List<OrderModel?>>> getOrdersHistory();
  Future<Result<OrderModel?>> cashPaymentMethod(ShippingAddressRequest shippingAddressRequest);
  Future<Result<CreditPaymentResponseModel?>> creditCardPaymentMethod(ShippingAddressRequest shippingAddressRequest);
}
