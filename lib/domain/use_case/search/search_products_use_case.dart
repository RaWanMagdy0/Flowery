import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../entities/home_layout/product_details_entity.dart';
import '../../repository/home/home_repository.dart';

@injectable
class SearchProductsUseCase {
  final HomeRepository _repository;

  SearchProductsUseCase(this._repository);

  Future<Result<List<ProductEntity>?>> invoke(String query) {
    return _repository.searchProducts(query);
  }
}