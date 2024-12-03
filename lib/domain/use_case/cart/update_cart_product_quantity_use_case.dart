import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../entities/cart/cart_response_entity.dart';
import '../../repository/cart/cart_repository.dart';

@injectable
class UpdateCartProductQuantityUseCase {
  final CartRepository _repository;

  UpdateCartProductQuantityUseCase(this._repository);

  Future<Result<CartResponse?>> call(String productId, int quantity) async {
    return await _repository.updateCartProductQuantity(productId, quantity);
  }
}
