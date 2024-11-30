import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_result.dart';
import '../../../../../core/base/base_view_model.dart';
import '../../../../../core/local/token_manger.dart';
import '../../../../../domain/entities/cart/cart_entity.dart';
import '../../../../../domain/use_case/cart/add_product_to_cart_use_case.dart';
import '../../../../../domain/use_case/cart/get_cart_products_use_case.dart';

part 'cart_state.dart';

@injectable
class CartViewModel extends BaseViewModel<CartState> {
  final GetCartProductsUseCase _getCartProductsUseCase;
  final AddProductToCartUseCase _addProductToCartUseCase;

  CartViewModel(
    this._getCartProductsUseCase,
    this._addProductToCartUseCase,
  ) : super(CartInitial());

  bool isUserLoggedIn = false;
  num cartItemsCount = 0;
  late Cart cart;

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
        cartItemsCount = result.data?.numberOfItems ?? 0;
        cart = result.data?.cart ?? Cart();
        emit(CartLoaded(result.data?.cart));
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

  void addProductToCart(String productId) async {
    emit(AddToCartLoading());

    final result = await _addProductToCartUseCase.call(productId);

    switch (result) {
      case Success():
        emit(AddToCartSuccess());
      case Fail():
        emit(
          CartError(getErrorMassageFromException(result.exception)),
        );
    }
  }
}
