import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../entities/home_layout/product_details_entity.dart';
import '../../../repository/home/occasions_repository.dart';

@injectable
class GetOccasionProductUseCase {
  final OccasionsRepository _repository;

  GetOccasionProductUseCase(this._repository);

  Future<Result<List<ProductEntity>?>> invoke(String id) async {
    return await _repository.getOccasionProducts(id);
  }
}
