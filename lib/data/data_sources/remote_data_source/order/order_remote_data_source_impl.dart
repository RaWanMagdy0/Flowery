import 'package:flowery/data/models/order/response/create_order_response/order_model.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result.dart';
import '../../../../core/api/execute_api_call.dart';
import '../../../../core/local/token_manger.dart';
import '../../../../domain/entities/address/create_order/order_entity.dart';
import '../../../api/order_api/order_api_manager.dart';
import '../../../models/order/request/create_order_request/create_order_request.dart';
import 'order_remote_data_source.dart';

@Injectable(as: OrderRemoteDataSource)

class OrderRemoteDataSourceImpl extends OrderRemoteDataSource{
  OrderApiManger apiManger;
  OrderRemoteDataSourceImpl({required this.apiManger});

  @override
  Future<Result<OrderModel?>> createOrder(CreateOrderRequest createOrderRequest)async {
      return await executeApiCall<OrderModel?>(()async{
        var token = await _getToken();
        var response=await apiManger.createOrder(token, createOrderRequest);
        return response;
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

