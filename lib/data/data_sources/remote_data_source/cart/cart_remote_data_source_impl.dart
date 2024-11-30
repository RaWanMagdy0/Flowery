import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../core/api/execute_api_call.dart';
import '../../../../core/local/token_manger.dart';
import '../../../api/cart_api/cart_api_manager.dart';
import '../../../models/cart/requests/add_to_cart_request_body_model.dart';
import '../../../models/cart/responses/cart_response_model.dart';
import 'cart_remote_data_source.dart';

@Injectable(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final CartApiManager apiManager;

  CartRemoteDataSourceImpl(this.apiManager);

  @override
  Future<Result<CartResponseModel>> getCartProducts() async {
    return await executeApiCall<CartResponseModel>(() async {
      String? token = await TokenManager.getToken();

      if (token == null || token.isEmpty) {
        final tokenException =
            Exception('Token is empty, please login and try again');
        throw tokenException;
        // return Fail(exception: tokenException);
      }

      token = 'Bearer $token';

      return await apiManager.getCartProducts(token);
    });
  }

  @override
  Future<Result<bool?>> addProductToCart(String productId) async {
    return await executeApiCall(() async {
      String? token = await TokenManager.getToken();

      if (token == null || token.isEmpty) {
        final tokenException =
            Exception('Token is empty, please login and try again');
        throw tokenException;
        // return Fail(exception: tokenException);
      }

      token = 'Bearer $token';

      final AddToCartRequestBodyModel body =
          AddToCartRequestBodyModel(productId: productId);

      return await apiManager.addProductToCart(token, body);
    });
  }
}
