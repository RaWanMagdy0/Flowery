import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/api/api_const.dart';
import '../../models/cart/cart_products_response_model.dart';

part 'cart_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class CartApiManager {
  @factoryMethod
  factory CartApiManager(Dio dio) = _CartApiManager;

  @GET(ApiConstants.getCartProducts)
  Future<CartProductsResponseModel> getCartProducts(
      @Header("Authorization") String token);
}
