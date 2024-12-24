import '../../../../../core/api/api_result.dart';
import '../../entities/home/home_category_entity.dart';
import '../../entities/home_layout/product_details_entity.dart';

abstract class CategoryRepository {
  Future<Result<List<HomeCategory>?>> getAllCategories();
  Future<Result<List<ProductEntity>?>> getCategoryProducts();
  Future<Result<List<ProductEntity?>?>> getSortedProducts(String sort);
}

