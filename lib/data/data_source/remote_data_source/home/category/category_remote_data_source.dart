import 'package:flowery/core/api/api_result.dart';

import '../../../../model/home/produc_details_model.dart';
import '../../../../models/home/home_category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<Result<HomeCategoryModel?>> getAllCategories();

  Future<Result<List<ProductModel>?>> getCategoriesProduct();
}
