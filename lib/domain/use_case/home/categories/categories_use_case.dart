import 'package:injectable/injectable.dart';
import '../../../../../core/api/api_result.dart';
import '../../../entities/home/home_category_entity.dart';
import '../../../repository/home/category_repository.dart';

@injectable
class GetAllCategoriesUseCase {
  CategoryRepository categoryRepository;

  GetAllCategoriesUseCase(this.categoryRepository);

  Future<Result<List<HomeCategory>?>> invoke() {
    return categoryRepository.getAllCategories();
  }
}