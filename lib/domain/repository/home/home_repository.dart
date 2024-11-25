import '../../../core/api/api_result.dart';
import '../../../data/model/home/produc_details_model.dart';
import '../../entities/home/home_data_entity.dart';

abstract class HomeRepository {
  Future<Result<HomeData?>> getHomeData();

  Future<Result<ProductDetailsModel?>> getProductDetails(
      {required String productId});
}
