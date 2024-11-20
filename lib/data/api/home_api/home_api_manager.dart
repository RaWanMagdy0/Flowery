import 'package:dio/dio.dart';
import 'package:flowery/data/model/auth/response/ProductDetailsModel.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../core/api/api_const.dart';

part 'home_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class HomeApiManger {
  @factoryMethod
  factory HomeApiManger(Dio dio) = _HomeApiManger;

  @GET(ApiConstants.productDetailsApi)
  Future<ProductDetailsModel?> getProductDetails(@Path("productId") String productId);

}
