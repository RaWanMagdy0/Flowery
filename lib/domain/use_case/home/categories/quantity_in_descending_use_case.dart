import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../entities/home_layout/product_details_entity.dart';
import '../../../repository/home/category_repository.dart';
@injectable
class ProductSortingUseCase {
  final CategoryRepository _repository;

  ProductSortingUseCase(this._repository);

  Future<Result<List<ProductEntity?>?>> invoke(String sortType) async {
    return await _repository.getSortedProducts(sortType);
  }
}