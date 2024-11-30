import '../../../core/api/api_result.dart';
import '../../entities/cart/cart_response_entity.dart';

abstract class CartRepository {
  Future<Result<CartResponse?>> getCartProducts();
  Future<Result<bool?>> addProductToCart(String productId);
}
