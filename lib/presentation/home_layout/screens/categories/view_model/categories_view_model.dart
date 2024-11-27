import 'dart:developer';

import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_result.dart';
import '../../../../../core/base/base_view_model.dart';
import '../../../../../domain/entities/home/home_category_entity.dart';
import '../../../../../domain/use_case/home/categories/categories_product_usecase.dart';
import '../../../../../domain/use_case/home/categories/categories_use_case.dart';
import 'categories_state.dart';

@injectable
class CategoriesViewModel extends BaseViewModel<CategoriesState> {
  final GetAllCategoriesUseCase categoriesUseCase;
  final CategoriesProductUseCase categoriesProductUseCase;

  CategoriesViewModel(this.categoriesUseCase, this.categoriesProductUseCase)
      : super(InitialState());

  Future<void> loadFlowers() async {
    emit(CategoriesLoadingState());
    var result = await categoriesUseCase.invoke();
    switch (result) {
      case Success<List<HomeCategory>?>():
        log('products: ${result.data}', name: 'Occasions prodcuts usecase');
        selectCategory(result.data!.first.id ?? '');
        emit(CategoriesSuccessState(result.data));

      case Fail<List<HomeCategory>?>():
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
