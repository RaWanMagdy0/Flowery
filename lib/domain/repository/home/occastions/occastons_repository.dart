import '../../../../core/api/api_result.dart';
import '../../../../data/models/occasions/occasions_response_model.dart';
import '../../../entities/home_layout/product_details_entity.dart';

abstract class OccasionsRepository {
  Future<Result<List<Occasions>?>> getOccasions();
  Future<Result<List<ProductEntity>?>> getOccasionsPrudact();
}
