import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_result.dart';
import '../../../../../core/api/execute_api_call.dart';
import '../../../../api/home_api/home_api_manager.dart';
import '../../../../models/home/best_seller/best_seller_model.dart';
import '../../../../models/home/home/home_data_model.dart';
import '../../../../models/produc_details_model.dart';
import 'home_remote_data_source.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  HomeApiManger apiManager;

  HomeRemoteDataSourceImpl(this.apiManager);

  @override
  Future<Result<HomeDataModel>> getHomeData() {
    return executeApiCall(() {
      return apiManager.getHomeData();
    });
  }

  @override
  Future<Result<ProductDetailsModel?>> getProductDetails(
      {required String productId}) {
    return executeApiCall<ProductDetailsModel?>(() async {
      final response = await apiManager.getProductDetails(productId);
      return response;
    });
  }

  @override
  Future<Result<List<BestSellerModel>>> getBestSellerProducts() {
    return executeApiCall(() async {
      final response = await apiManager.getBestSellerProducts();
      return response.bestSellers!;
    });
  }
}
