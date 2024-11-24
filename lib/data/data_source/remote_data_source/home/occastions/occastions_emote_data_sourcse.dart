import '../../../../../core/api/api_result.dart';
import '../../../../model/home/produc_details_model.dart';
import '../../../../models/occasions/occasions_response_model.dart';

abstract class OccastionsRmoteDataSourcse {
  Future<Result<OccasionsResponseModel?>> getOccasions();
  Future<Result<List<ProductModel>?>> getOccasionsPrudact();
}
