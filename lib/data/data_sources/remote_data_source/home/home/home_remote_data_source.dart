import '../../../../../core/api/api_result.dart';
import '../../../../models/home/best_seller/best_seller_model.dart';
import '../../../../models/home/home/home_data_model.dart';
import '../../../../models/produc_details_model.dart';

abstract class HomeRemoteDataSource {
  Future<Result<HomeDataModel>> getHomeData();

  Future<Result<ProductDetailsModel?>> getProductDetails(
      {required String productId});

  Future<Result<List<BestSellerModel>>> getBestSellerProducts();
}
