import '../../../../core/api/api_result.dart';
import '../../../models/cart/responses/cart_response_model.dart';

abstract class CartRemoteDataSource {
  Future<Result<CartResponseModel>> getCartProducts();
  Future<Result<dynamic>> addProductToCart(String productId);
  Future<Result<CartResponseModel>> updateCartProductQuantity(
      String productId, int quantity);
  Future<Result<dynamic>> removeProductFromCart(String productId);
  Future<Result<dynamic>> clearCart();
}
