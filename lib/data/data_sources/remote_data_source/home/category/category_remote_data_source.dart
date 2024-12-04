import '../../../../../core/api/api_result.dart';
import '../../../../models/home/category/all_categories_response_model.dart';
import '../../../../models/produc_details_model.dart';

abstract class CategoryRemoteDataSource {
  Future<Result<AllCategoriesResponseModel>> getAllCategories();
  Future<Result<List<ProductModel>?>> getCategoriesProduct();
}