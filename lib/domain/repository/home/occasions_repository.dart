import '../../../core/api/api_result.dart';
import '../../../data/models/home/occasions/occasions_response_model.dart';
import '../../entities/home_layout/product_details_entity.dart';

abstract class OccasionsRepository {
  Future<Result<List<Occasions>?>> getAllOccasions();
  Future<Result<List<ProductEntity>?>> getOccasionProducts(String id);
}
