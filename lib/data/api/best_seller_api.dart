import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/api/api_const.dart';
import '../models/best_seller_response_model.dart';

part 'best_seller_api.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class BestSellerApi {
  @factoryMethod
  factory BestSellerApi(Dio dio) = _BestSellerApi;

  @GET(ApiConstants.getBestSeller)
  Future<BestSellerResponseModel> getBestSellers();
}
