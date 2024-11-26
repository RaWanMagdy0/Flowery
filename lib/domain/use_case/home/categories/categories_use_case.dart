import 'package:flowery/data/models/home/home_category_model.dart';
import 'package:flowery/domain/repository/category_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_result.dart';

@injectable
class CategoriesUseCase {
  CategoryRepository categoryRepository;

  CategoriesUseCase(this.categoryRepository);

  Future<Result<List<HomeCategoryModel>?>> invoke() {
    return categoryRepository.getAllCategories();
  }
}
