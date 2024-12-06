
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/api/api_const.dart';
import '../../models/order/request/create_order_request/create_order_request.dart';
import '../../models/order/response/create_order_response/create_order_model.dart';

part 'order_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class OrderApiManger {
  @factoryMethod
  factory OrderApiManger(Dio dio) = _OrderApiManger;

  @POST(ApiConstants.createOrder)
  Future<CreateOrderModel?> createOrder(
    @Header("Authorization") String token,
    @Body() CreateOrderRequest createOrderRequest,
  );
}
