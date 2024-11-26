import 'package:flowery/data/models/home/home_category_model.dart';

import '../../../../../domain/entities/home_layout/product_details_entity.dart';

abstract class CategoriesState {}

class InitialState extends CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesErrorState extends CategoriesState {
  final Exception? exception;

  CategoriesErrorState(this.exception);
}

class CategoriesSuccessState extends CategoriesState {
  final List<HomeCategoryModel>? categories;

  CategoriesSuccessState(this.categories);
}

class GetCategoriesProductLoadingState extends CategoriesState {}

class GetCategoriesProductErrorState extends CategoriesState {
  final Exception? exception;

  GetCategoriesProductErrorState(this.exception);
}

class GetCategoriesProductSuccessState extends CategoriesState {
  final List<ProductEntity?>? product;

  GetCategoriesProductSuccessState(this.product);
}
