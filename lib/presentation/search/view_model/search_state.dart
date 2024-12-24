import '../../../domain/entities/home_layout/product_details_entity.dart';

sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<ProductEntity> products;

  SearchSuccess(this.products);
}

final class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}