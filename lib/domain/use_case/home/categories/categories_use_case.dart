import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_result.dart';
import '../../../entities/home/home_category_entity.dart';
import '../../../repository/home/category_repository.dart';

@injectable
class GetAllCategoriesUseCase {
@Injectable()
class CategoriesUseCase {
  CategoryRepository categoryRepository;

  GetAllCategoriesUseCase(this.categoryRepository);
  CategoriesUseCase(this.categoryRepository);

  Future<Result<List<HomeCategory>?>> invoke() {
  Future<Result<List<HomeCategoryModel>?>> invoke() {
    return categoryRepository.getAllCategories();
  }
}
