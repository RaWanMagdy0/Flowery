import 'dart:developer';

import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_result.dart';
import '../../../../../core/api/execute_api_call.dart';
import '../../../../api/home_api/home_api_manager.dart';
import '../../../../models/home/occasions/occasions_response_model.dart';
import '../../../../models/produc_details_model.dart';
import 'occasions_remote_data_sourcse.dart';

@Injectable(as: OccastionsRmoteDataSourcse)
class OccastionsRemoteDataSorceImpl extends OccastionsRmoteDataSourcse {
  HomeApiManger apiManger;

  OccastionsRemoteDataSorceImpl({required this.apiManger});

  @override
  Future<Result<OccasionsResponseModel?>> getOccasions() {
    return executeApiCall<OccasionsResponseModel?>(() async {
      return await apiManger.getAllOccasions();
    });
  }

  @override
  Future<Result<List<ProductModel>?>> getOccasionsPrudact() {
    return executeApiCall(() async {
      final response = await apiManger.getOccasionProducts();
      final data = response.products;
      log('data: $data', name: 'OccastionsRemoteDataSorceImpl');
      return data!;
    });
  }
}
