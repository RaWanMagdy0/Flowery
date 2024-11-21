import 'package:flowery/data/model/auth/response/produc_details_model.dart';

import '../../../../core/api/api_result.dart';
import '../../../models/home/home_data_model.dart';

abstract class HomeRemoteDataSource {
  Future<Result<HomeDataModel>> getHomeData();

  Future<Result<ProductDetailsModel?>> getProductDetails(
      {required String productId});
}
