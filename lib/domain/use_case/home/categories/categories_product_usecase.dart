import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_result.dart';
import '../../../entities/home_layout/product_details_entity.dart';
import '../../../repository/home/category_repository.dart';

@injectable
class CategoriesProductUseCase {
  final CategoryRepository _repository;

  CategoriesProductUseCase(this._repository);

  Future<Result<List<ProductEntity>?>> invoke(String id) async {
    return await _repository.getCategoryProducts(id);
  }
}
