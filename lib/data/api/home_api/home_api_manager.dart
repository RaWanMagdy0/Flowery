import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/api/api_const.dart';
import '../../models/home/best_seller/best_seller_response_model.dart';
import '../../models/home/category/all_categories_response_model.dart';
import '../../models/home/home/home_data_model.dart';
import '../../models/home/occasions/occasions_response_model.dart';
import '../../models/produc_details_model.dart';

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

  @GET(ApiConstants.getBestSellerProducts)
  Future<BestSellerResponseModel> getBestSellerProducts();

  @GET(ApiConstants.getAllCategories)
  Future<AllCategoriesResponseModel> getAllCategories();

  @GET(ApiConstants.getAllProducts)
  Future<ProductDetailsModel> getCategoryProducts();

  @GET(ApiConstants.getAllOccasions)
  Future<OccasionsResponseModel> getAllOccasions();

  @GET(ApiConstants.getAllProducts)
  Future<ProductDetailsModel> getOccasionProducts();
}
