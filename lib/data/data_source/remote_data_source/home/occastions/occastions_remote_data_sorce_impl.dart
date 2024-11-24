import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/core/api/execute_api_call.dart';
import 'package:flowery/data/api/home_api/home_api_manager.dart';
import 'package:flowery/data/data_source/remote_data_source/home/occastions/occastions_emote_data_sourcse.dart';
import 'package:flowery/data/models/best_seller_model.dart';
import 'package:flowery/data/models/occasions/occasions_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OccastionsRmoteDataSourcse)
class OccastionsRemoteDataSorceImpl extends OccastionsRmoteDataSourcse {
  HomeApiManger apiManger;

  OccastionsRemoteDataSorceImpl({required this.apiManger});

  @override
  Future<Result<OccasionsResponseModel?>> GetOccasions() {
    return executeApiCall<OccasionsResponseModel?>(apiCall: () async {
      return await apiManger.occasions();
    });
  }

  @override
  Future<Result<List<BestSellerModel>>> getOccasionsPrudact() {
    return executeApiCall(apiCall: () async {
      final response = await apiManger.getOccasionsPrudact();
      final List<dynamic> data = response['products'];
      return data.map((json) => BestSellerModel.fromJson(json)).toList();
    });
  }
}
