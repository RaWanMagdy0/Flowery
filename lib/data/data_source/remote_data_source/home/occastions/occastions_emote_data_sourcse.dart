import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/models/best_seller_model.dart';
import 'package:flowery/data/models/occasions/occasions_response_model.dart';

abstract class OccastionsRmoteDataSourcse {
  Future<Result<OccasionsResponseModel?>> GetOccasions();
  Future<Result<List<BestSellerModel>>> getOccasionsPrudact();
}
