import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../entities/cart/cart_response_entity.dart';
import '../../repository/cart/cart_repository.dart';

@injectable
class GetCartProductsUseCase {
  final CartRepository _repository;

  GetCartProductsUseCase(this._repository);

  Future<Result<CartResponse?>> call() async {
    return await _repository.getCartProducts();
  }
}
