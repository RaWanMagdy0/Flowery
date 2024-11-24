import '../../../../core/api/api_result.dart';
import '../../../model/auth/response/produc_details_model.dart';
import '../../../models/home/home_data_model.dart';

abstract class HomeRemoteDataSource {
  Future<Result<HomeDataModel>> getHomeData();

  Future<Result<ProductDetailsModel?>> getProductDetails(
      {required String productId});
}
