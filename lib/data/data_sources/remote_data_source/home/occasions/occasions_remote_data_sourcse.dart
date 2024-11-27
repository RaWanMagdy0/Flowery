import '../../../../../core/api/api_result.dart';
import '../../../../models/home/occasions/occasions_response_model.dart';
import '../../../../models/produc_details_model.dart';

abstract class OccastionsRmoteDataSourcse {
  Future<Result<OccasionsResponseModel?>> getOccasions();
  Future<Result<List<ProductModel>?>> getOccasionsPrudact();
}
