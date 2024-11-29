import '../../../core/api/api_result.dart';
import '../../entities/cart/cart_product_entity.dart';

abstract class CartRepository {
  Future<Result<List<CartProduct>?>> getCartProducts();
}
