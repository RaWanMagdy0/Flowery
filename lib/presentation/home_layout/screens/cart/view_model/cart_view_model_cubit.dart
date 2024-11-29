import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_result.dart';
import '../../../../../core/base/base_view_model.dart';
import '../../../../../core/local/token_manger.dart';
import '../../../../../domain/entities/cart/cart_product_entity.dart';
import '../../../../../domain/use_case/cart/get_cart_products_use_case.dart';

part 'cart_state.dart';

@injectable
class CartViewModel extends BaseViewModel<CartState> {
  final GetCartProductsUseCase _getCartProductsUseCase;

  CartViewModel(this._getCartProductsUseCase) : super(CartInitial());

  bool isUserLoggedIn = false;
  int cartItemsCount = 0;

  void checkLoggedUser() async {
    final token = await TokenManager.getToken();

    if (token != null && token.isNotEmpty) {
      isUserLoggedIn = true;
    } else {
      isUserLoggedIn = false;
      emit(NoUserLogged());
    }
  }

  void getCartProducts() async {
    emit(CartLoading());
    cartItemsCount = 0;

    final result = await _getCartProductsUseCase.call();

    switch (result) {
      case Success():
        cartItemsCount = result.data?.length ?? 0;
        emit(CartLoaded(result.data));
      case Fail():
        if (result.exception.toString().contains('404')) {
          emit(CartEmpty());
        } else {
          emit(
            CartError(getErrorMassageFromException(result.exception)),
          );
        }
    }
  }
}
