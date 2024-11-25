import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../entities/home_layout/product_details_entity.dart';
import '../../../repository/home/occastions/occastons_repository.dart';

@injectable
class GetPrudactUseCase {
  final OccasionsRepository _repository;

  GetPrudactUseCase(this._repository);

  Future<Result<List<ProductEntity?>>> invoke(String id) async {
    final result = await _repository.getOccasionsPrudact();
    switch (result) {
      case Success():
        List<ProductEntity>? products = [];

        for (var model in result.data!) {
          if (model.occasion == id) {
            products.add(model);
          }
        }

        return Success(data: products);
      case Fail():
        return Fail(exception: result.exception);
    }
  }
}
