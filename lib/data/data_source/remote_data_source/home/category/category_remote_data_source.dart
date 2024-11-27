import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/model/auth/response/produc_details_model.dart';

import '../../../../../domain/entities/home/home_category_entity.dart';
import '../../../../models/home/home_category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<Result<HomeCategoryModel?>> getAllCategories();

  Future<Result<List<ProductModel>?>> getCategoriesProduct();
}
