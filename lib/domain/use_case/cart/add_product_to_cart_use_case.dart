import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../repository/cart/cart_repository.dart';

@injectable
class AddProductToCartUseCase {
  final CartRepository _cartRepository;

  AddProductToCartUseCase(this._cartRepository);

  Future<Result<bool?>> call(String productId) async {
    return await _cartRepository.addProductToCart(productId);
  }
}
