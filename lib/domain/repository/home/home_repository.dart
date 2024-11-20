import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/model/auth/response/ProductDetailsModel.dart';

abstract class HomeRepository {
  Future<Result<ProductDetailsModel?>>getProductDetails({required String productId});
}
