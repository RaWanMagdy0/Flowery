import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../entities/cart/cart_product_entity.dart';
import '../../repository/cart/cart_repository.dart';

@injectable
class GetCartProductsUseCase {
  final CartRepository _repository;

  GetCartProductsUseCase(this._repository);

  Future<Result<List<CartProduct>?>> call() async {
    return await _repository.getCartProducts();
  }
}
