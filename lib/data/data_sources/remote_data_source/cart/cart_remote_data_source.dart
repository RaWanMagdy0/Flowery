import '../../../../core/api/api_result.dart';
import '../../../models/cart/responses/cart_response_model.dart';

abstract class CartRemoteDataSource {
  Future<Result<CartResponseModel>> getCartProducts();
  Future<Result<bool?>> addProductToCart(String productId);
}
