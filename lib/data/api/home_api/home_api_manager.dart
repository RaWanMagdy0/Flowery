import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/api/api_const.dart';
import '../../model/auth/response/produc_details_model.dart';

import '../../models/home/home_category_model.dart';
import '../../models/home/home_data_model.dart';

part 'home_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class HomeApiManger {
  @factoryMethod
  factory HomeApiManger(Dio dio) = _HomeApiManger;

  @GET(ApiConstants.getHomeData)
  Future<HomeDataModel> getHomeData();

  @GET(ApiConstants.productDetails)
  Future<ProductDetailsModel?> getProductDetails(
      @Path("productId") String productId);

  @GET(ApiConstants.getAllProducts)
  Future<ProductDetailsModel> getOccasionsPrudact();

  @GET(ApiConstants.getAllCategoriesEndpoint)
  Future<HomeCategoryModel> getAllCategories();

  @GET(ApiConstants.getAllProducts)
  Future<ProductDetailsModel> getCategoriesProduct();
}
