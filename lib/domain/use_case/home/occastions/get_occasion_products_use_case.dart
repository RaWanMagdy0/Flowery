import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../entities/home_layout/product_details_entity.dart';
import '../../../repository/home/occasions_repository.dart';

@injectable
class GetOccasionProductUseCase {
  final OccasionsRepository _repository;

  GetOccasionProductUseCase(this._repository);

  Future<Result<List<ProductEntity?>>> invoke(String id) async {
    final result = await _repository.getOccasionProducts();
    switch (result) {
      case Success():
        List<ProductEntity>? products = [];

        for (var model in result.data!) {
          if (model.occasion == id) {
            products.add(model);
          }
        }

        return Success<List<ProductEntity?>>(data: products);
      case Fail():
        return Fail<List<ProductEntity?>>(exception: result.exception);
    }
  }
}
