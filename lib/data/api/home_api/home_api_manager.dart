import 'package:dio/dio.dart';
import 'package:flowery/data/model/auth/response/produc_details_model.dart';
import 'package:flowery/data/models/occasions/occasions_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../core/api/api_const.dart';
import '../../models/home/home_data_model.dart';

part 'home_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class HomeApiManger {
  @factoryMethod
  factory HomeApiManger(Dio dio) = _HomeApiManger;

  @GET(ApiConstants.getHomeData)
  Future<HomeDataModel> getHomeData();

  @GET(ApiConstants.productDetailsApi)
  Future<ProductDetailsModel?> getProductDetails(
      @Path("productId") String productId);

  @GET(ApiConstants.occasionsApi)
  Future<OccasionsResponseModel> occasions();
}
