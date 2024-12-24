import '../../../../../domain/entities/home/home_category_entity.dart';
import '../../../../../domain/entities/home_layout/product_details_entity.dart';

abstract class CategoriesState {
  // Base getter that returns null by default
  List<ProductEntity?>? get product => null;
}

class InitialState extends CategoriesState {}

// getCategories
class CategoriesLoadingState extends CategoriesState {}

class CategoriesErrorState extends CategoriesState {
  final Exception? exception;

  CategoriesErrorState(this.exception);
}

class CategoriesSuccessState extends CategoriesState {
  final List<HomeCategory>? categories;

  CategoriesSuccessState(this.categories);
}

// getCategoriesProduct
class GetCategoriesProductLoadingState extends CategoriesState {}

class GetCategoriesProductErrorState extends CategoriesState {
  final Exception? exception;

  GetCategoriesProductErrorState(this.exception);
}

class GetCategoriesProductSuccessState extends CategoriesState {
  @override
  final List<ProductEntity?>? product;

  GetCategoriesProductSuccessState(this.product);
}

// getProductsBySort
class ProductInitialState extends CategoriesState {}

class ProductSortLoadingState extends CategoriesState {}

class ProductSortSuccessState extends CategoriesState {
  @override
  final List<ProductEntity?>? product;

  ProductSortSuccessState(this.product);
}

class ProductSortErrorState extends CategoriesState {
  final Exception? exception;
  ProductSortErrorState(this.exception);
}