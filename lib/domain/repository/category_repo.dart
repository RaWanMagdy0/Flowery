import 'package:flowery/domain/entities/home_layout/product_details_entity.dart';

import '../../../../core/api/api_result.dart';
import '../../data/models/home/home_category_model.dart';
import '../entities/home/home_category_entity.dart';

abstract class CategoryRepository {
  Future<Result<List<HomeCategoryModel>?>> getAllCategories();

  Future<Result<List<ProductEntity>?>> getCategoriesProduct();
}
