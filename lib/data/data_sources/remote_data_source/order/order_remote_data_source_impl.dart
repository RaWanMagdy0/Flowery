import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../core/api/execute_api_call.dart';
import '../../../../core/local/token_manger.dart';
import '../../../../domain/entities/address/create_order/order.dart';
import '../../../api/order_api/order_api_manager.dart';
import '../../../models/order/request/create_order_request/create_order_request.dart';
import 'order_remote_data_source.dart';

@Injectable(as: OrderRemoteDataSource)
class OrderRemoteDataSourceImpl extends OrderRemoteDataSource {
  OrderApiManger apiManger;

  OrderRemoteDataSourceImpl(this.apiManger);

  @override
  Future<Result<OrderEntity?>> createOrder(
      CreateOrderRequest createOrderRequest) async {
    return await executeApiCall<OrderEntity?>(() async {
      var token = await _getToken();
      var response = await apiManger.createOrder(token, createOrderRequest);
      return response?.toOrder();
    });
  }

  Future<String> _getToken() async {
    var token = await TokenManager.getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token is missing. Please login again.");
    }
    return 'Bearer $token';
  }
}
