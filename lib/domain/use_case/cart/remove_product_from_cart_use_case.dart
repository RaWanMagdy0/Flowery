import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../repository/cart/cart_repository.dart';

@injectable
class RemoveProductFromCartUseCase {
  final CartRepository _cartRepository;

  RemoveProductFromCartUseCase(this._cartRepository);

  Future<Result<bool?>> call(String productId) async {
    return await _cartRepository.removeProductFromCart(productId);
  }
}
