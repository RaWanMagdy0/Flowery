import 'dart:developer';

import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_result.dart';
import '../../../../../core/api/execute_api_call.dart';
import '../../../../api/home_api/home_api_manager.dart';
import '../../../../model/home/produc_details_model.dart';
import '../../../../models/occasions/occasions_response_model.dart';
import 'occastions_emote_data_sourcse.dart';

@Injectable(as: OccastionsRmoteDataSourcse)
class OccastionsRemoteDataSorceImpl extends OccastionsRmoteDataSourcse {
  HomeApiManger apiManger;

  OccastionsRemoteDataSorceImpl({required this.apiManger});

  @override
  Future<Result<OccasionsResponseModel?>> getOccasions() {
    return executeApiCall<OccasionsResponseModel?>(apiCall: () async {
      return await apiManger.occasions();
    });
  }

  @override
  Future<Result<List<ProductModel>?>> getOccasionsPrudact() {
    return executeApiCall(apiCall: () async {
      final response = await apiManger.getOccasionsPrudact();
      final data = response.products;
      log('data: $data', name: 'OccastionsRemoteDataSorceImpl');
      return data!;
    });
  }
}
