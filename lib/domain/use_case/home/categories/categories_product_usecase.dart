import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_result.dart';
import '../../../entities/home_layout/product_details_entity.dart';
import '../../../repository/home/category_repository.dart';

@injectable
class CategoriesProductUseCase {
  final CategoryRepository _repository;

  CategoriesProductUseCase(this._repository);

  Future<Result<List<ProductEntity>?>> invoke(String id) async {
    final result = await _repository.getCategoryProducts();
    switch (result) {
      case Success():

        List<ProductEntity>? products = [];

        for (var model in result.data!) {
          products.add(model);
        }
        return Success(data: products);
      case Fail():
        return Fail(exception: result.exception);
    }
  }
}