import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/core/api/execute_api_call.dart';
import 'package:flowery/data/model/home/produc_details_model.dart';
import 'package:injectable/injectable.dart';

import '../../../api/home_api/home_api_manager.dart';
import '../../../models/home/home_data_model.dart';
import 'home_remote_data_source.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  HomeApiManger apiManger;
  HomeRemoteDataSourceImpl({required this.apiManger});

  @override
  Future<Result<HomeDataModel>> getHomeData() {
    return executeApiCall(apiCall: () {
      return apiManger.getHomeData();
    });
  }

  @override
  Future<Result<ProductDetailsModel?>> getProductDetails(
      {required String productId}) {
    return executeApiCall<ProductDetailsModel?>(apiCall: () async {
      final response = await apiManger.getProductDetails(productId);
      return response;
    });
  }
}
