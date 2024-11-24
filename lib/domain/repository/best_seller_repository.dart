import '../../core/api/api_result.dart';
import '../entities/best_seller_entity.dart';

abstract class BestSellerRepository {
  Future<Result<List<BestSeller>>> getBestSellers();
}