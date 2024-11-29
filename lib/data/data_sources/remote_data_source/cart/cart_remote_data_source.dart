import '../../../../core/api/api_result.dart';
import '../../../models/cart/cart_products_response_model.dart';

abstract class CartRemoteDataSource {
  Future<Result<CartProductsResponseModel>> getCartProducts();
}
