import 'package:flowery/data/models/home/home_category_model.dart';
import 'package:flowery/domain/use_case/home/categories/categories_product_usecase.dart';
import 'package:flowery/domain/use_case/home/categories/categories_use_case.dart';
import 'package:flowery/presentation/home_layout/screens/categories/view_model/categories_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_result.dart';
import '../../../../../core/base/base_view_model.dart';

@injectable
class CategoriesViewModel extends BaseViewModel<CategoriesState> {
  final CategoriesUseCase categoriesUseCase;
  final CategoriesProductUseCase categoriesProductUseCase;

  CategoriesViewModel(this.categoriesUseCase, this.categoriesProductUseCase)
      : super(InitialState());

  Future<void> loadFlowers() async {
    emit(CategoriesLoadingState());
    var result = await categoriesUseCase.invoke();
    switch (result) {
      case Success<List<HomeCategoryModel>?>():
        emit(CategoriesSuccessState(result.data));

      case Fail<List<HomeCategoryModel>?>():
        emit(CategoriesErrorState(result.exception));
    }
  }

  void selectCategory(String id) async {
    emit((GetCategoriesProductLoadingState()));
    var result = await categoriesProductUseCase.invoke(id);
    switch (result) {
      case Success():
        emit(GetCategoriesProductSuccessState(result.data));

      case Fail():
        emit(GetCategoriesProductErrorState(result.exception));
    }
  }
}
