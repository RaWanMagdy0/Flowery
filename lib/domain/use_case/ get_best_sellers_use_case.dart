import 'package:injectable/injectable.dart';

import '../../core/api/api_result.dart';
import '../entities/best_seller_entity.dart';
import '../repository/best_seller_repository.dart';

@injectable
class GetBestSellersUseCase {
  final BestSellerRepository _repository;

  GetBestSellersUseCase(this._repository);

  Future<Result<List<BestSeller>>> invoke() {
    return _repository.getBestSellers();
  }
}