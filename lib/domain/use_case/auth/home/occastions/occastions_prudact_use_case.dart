import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/repository/home/occastions/occastons_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../entities/best_seller_entity.dart';

@injectable
class GetPrudactUseCase {
  final OccasionsRepository _repository;

  GetPrudactUseCase(this._repository);

  Future<Result<List<BestSeller?>>> invoke(String id) async {
    final result = await _repository.getOccasionsPrudact();
    switch (result) {
      case Success():
        final products = result.data?.map((model) {
              if (model.id == id) {
                return model;
              }
            }).toList() ??
            [];
        return Success(data: products);
      case Fail():
        return Fail(exception: result.exception);
    }
  }
}
