import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/api/api_const.dart';
import '../../models/cart/requests/add_to_cart_request_body_model.dart';
import '../../models/cart/responses/cart_response_model.dart';

part 'cart_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class CartApiManager {
  @factoryMethod
  factory CartApiManager(Dio dio) = _CartApiManager;

  @GET(ApiConstants.cart)
  Future<CartResponseModel> getCartProducts(
      @Header("Authorization") String token);

  @POST(ApiConstants.cart)
  Future<dynamic> addProductToCart(
    @Header("Authorization") String token,
    @Body() AddToCartRequestBodyModel addToCartRequestBodyModel,
  );

  @PUT('${ApiConstants.cart}/{productId}')
  Future<CartResponseModel> updateCartProductQuantity(
    @Path("productId") String productId,
    @Header("Authorization") String token,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('${ApiConstants.cart}/{productId}')
  Future<CartResponseModel> removeProductFromCart(
    @Path("productId") String productId,
    @Header("Authorization") String token,
  );

  @DELETE(ApiConstants.cart)
  Future<dynamic> clearCart(@Header("Authorization") String token);
}
