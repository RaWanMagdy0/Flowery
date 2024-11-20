import 'package:flowery/data/model/auth/response/ProductDetailsModel.dart';

import '../../../../core/api/api_result.dart';

abstract class HomeRemoteDataSource {
  Future<Result<ProductDetailsModel?>>getProductDetails({required String productId});
}
