import 'package:flowery/data/models/payment/response/credit_payment_response_model.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result.dart';
import '../../../../core/api/execute_api_call.dart';
import '../../../../core/local/token_manger.dart';
import '../../../api/order_api/order_api_manager.dart';
import '../../../models/order/request/create_order_request/create_order_request.dart';
import '../../../models/order/response/create_order_response/order_response_model.dart';
import '../../../models/payment/request/payment_request_model.dart';
import 'order_remote_data_source.dart';

@Injectable(as: OrderRemoteDataSource)
class OrderRemoteDataSourceImpl extends OrderRemoteDataSource {
  OrderApiManger apiManger;

  OrderRemoteDataSourceImpl({required this.apiManger});

  @override
  Future<Result<OrderModell?>> createOrder(
      CreateOrderRequest createOrderRequest) async {
    return await executeApiCall<OrderModell?>(() async {
      var token = await _getToken();
      var response = await apiManger.createOrder(token, createOrderRequest);
      return response;
    });
  }

  @override
  Future<Result<OrderModell?>> getOrdersHistory() async {
    return await executeApiCall<OrderModell?>(() async {
      var token = await _getToken();
      var response = await apiManger.getOrdersHistory(token);
      return response?.orders;
    });
  }

  Future<String> _getToken() async {
    var token = await TokenManager.getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token is missing. Please login again.");
    }
    return 'Bearer $token';
  }

  @override
  Future<Result<OrderModell?>> cashPaymentMethod(
      ShippingAddressRequest shippingAddressRequest) async {
    return await executeApiCall<OrderModell?>(() async {
      var token = await _getToken();
      var response =
          await apiManger.cashPaymentMethod(token, shippingAddressRequest);
      return response.orders;
    });
  }

  @override
  Future<Result<CreditPaymentResponseModel?>> creditCardPaymentMethod(
      ShippingAddressRequest shippingAddressRequest) async {
    return await executeApiCall<CreditPaymentResponseModel?>(() async {
      var token = await _getToken();
      var response = await apiManger.creditCardPaymentMethod(
          token, shippingAddressRequest);
      return response;
    });
  }
}
