import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../entities/best_seller_entity.dart';
import '../../repository/home/home_repository.dart';

@injectable
class GetBestSellerProductsUseCase {
  HomeRepository repository;

  GetBestSellerProductsUseCase({required this.repository});

  Future<Result<List<BestSeller>>> invoke() {
    return repository.getBestSellerProducts();
  }
}
