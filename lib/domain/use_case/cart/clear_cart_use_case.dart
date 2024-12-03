import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../repository/cart/cart_repository.dart';

@injectable
class ClearCartUseCase {
  final CartRepository _cartRepository;

  ClearCartUseCase(this._cartRepository);

  Future<Result<bool?>> call() async {
    return await _cartRepository.clearCart();
  }
}
