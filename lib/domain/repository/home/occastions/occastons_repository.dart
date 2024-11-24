import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/models/occasions/occasions_response_model.dart';
import 'package:flowery/domain/entities/best_seller_entity.dart';

abstract class OccasionsRepository {
  Future<Result<List<Occasions>?>> GetOccasions();
  Future<Result<List<BestSeller>>> getOccasionsPrudact();
}
