import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../core/base/base_view_model.dart';
import '../../../domain/entities/home_layout/product_details_entity.dart';
import '../../../domain/use_case/search/search_products_use_case.dart';
import 'search_state.dart';

@injectable
class SearchCubit extends BaseViewModel<SearchState> {
  final SearchProductsUseCase _searchProductsUseCase;

  SearchCubit(this._searchProductsUseCase) : super(SearchInitial());

  Future<void> searchProducts(String query) async {
    emit(SearchLoading());

    final result = await _searchProductsUseCase.invoke(query);

    switch (result) {
      case Success():
        emit(SearchSuccess(result.data ?? []));
      case Fail():
        emit(SearchError(getErrorMassageFromException(result.exception)));
    }
  }

  void clearSearch() {
    emit(SearchInitial());
  }
}