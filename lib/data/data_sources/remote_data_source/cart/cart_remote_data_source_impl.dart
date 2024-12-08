import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../core/api/execute_api_call.dart';
import '../../../../core/errors/custom_exceptions.dart';
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
            TokenException('Token is empty, please login and try again');
        throw tokenException;
      }
      token = 'Bearer $token';

      return await apiManager.getCartProducts(token);
    });
  }

  @override
  Future<Result<dynamic>> addProductToCart(String productId) async {
    return await executeApiCall<dynamic>(() async {
      String? token = await TokenManager.getToken();

      if (token == null || token.isEmpty) {
        final tokenException =
            TokenException('Token is empty, please login and try again');
        throw tokenException;
      }

      token = 'Bearer $token';

      final AddToCartRequestBodyModel body =
          AddToCartRequestBodyModel(productId: productId);

      await apiManager.addProductToCart(token, body);

      return true;
    });
  }

  @override
  Future<Result<CartResponseModel>> updateCartProductQuantity(
      String productId, int quantity) async {
    return await executeApiCall<CartResponseModel>(() async {
      String? token = await TokenManager.getToken();

      if (token == null || token.isEmpty) {
        final tokenException =
            TokenException('Token is empty, please login and try again');
        throw tokenException;
      }

      token = 'Bearer $token';

      final body = {"quantity": quantity};

      return await apiManager.updateCartProductQuantity(productId, token, body);
    });
  }

  @override
  Future<Result> removeProductFromCart(String productId) async {
    return await executeApiCall<dynamic>(() async {
      String? token = await TokenManager.getToken();

      if (token == null || token.isEmpty) {
        final tokenException =
            TokenException('Token is empty, please login and try again');
        throw tokenException;
      }

      token = 'Bearer $token';

      await apiManager.removeProductFromCart(productId, token);

      return true;
    });
  }

  @override
  Future<Result> clearCart() async {
    return await executeApiCall<dynamic>(() async {
      String? token = await TokenManager.getToken();

      if (token == null || token.isEmpty) {
        final tokenException =
            TokenException('Token is empty, please login and try again');
        throw tokenException;
      }

      token = 'Bearer $token';

      await apiManager.clearCart(token);

      return true;
    });
  }
}
