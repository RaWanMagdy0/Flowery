import 'package:flowery/domain/entities/cart/cart_product_entity.dart';
import 'package:flowery/domain/entities/home_layout/product_details_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_result.dart';
import '../../../../../core/base/base_view_model.dart';
import '../../../../../core/errors/custom_exceptions.dart';
import '../../../../../core/local/token_manger.dart';
import '../../../../../domain/entities/cart/cart_entity.dart';
import '../../../../../domain/use_case/cart/add_product_to_cart_use_case.dart';
import '../../../../../domain/use_case/cart/clear_cart_use_case.dart';
import '../../../../../domain/use_case/cart/get_cart_products_use_case.dart';
import '../../../../../domain/use_case/cart/remove_product_from_cart_use_case.dart';
import '../../../../../domain/use_case/cart/update_cart_product_quantity_use_case.dart';

part 'cart_state.dart';

@injectable
class CartViewModel extends BaseViewModel<CartState> {
  final GetCartProductsUseCase _getCartProductsUseCase;
  final AddProductToCartUseCase _addProductToCartUseCase;
  final UpdateCartProductQuantityUseCase _updateCartProductQuantityUseCase;
  final RemoveProductFromCartUseCase _removeProductFromCartUseCase;
  final ClearCartUseCase _clearCartUseCase;

  CartViewModel(
    this._getCartProductsUseCase,
    this._addProductToCartUseCase,
    this._updateCartProductQuantityUseCase,
    this._removeProductFromCartUseCase,
    this._clearCartUseCase,
  ) : super(CartInitial());

  bool isUserLoggedIn = false;
  num cartItemsCount = 0;
  late Cart cart;
  void checkLoggedUser() async {
    final token = await TokenManager.getToken();

    if (token != null && token.isNotEmpty) {
      isUserLoggedIn = true;
      emit(UserLogged());
    } else {
      isUserLoggedIn = false;
      emit(NoUserLogged());
    }
  }

  void getCartProducts() async {
    if (!isUserLoggedIn) {
      emit(NoUserLogged());
      return;
    }

    emit(CartLoading());
    cartItemsCount = 0;

    final result = await _getCartProductsUseCase.call();

    switch (result) {
      case Success():
        cartItemsCount = result.data?.numberOfItems ?? 0;
        cart = result.data?.cart ?? Cart();

        if (cart.products?.isEmpty ?? true) {
          emit(CartEmpty());
        } else {
          emit(CartLoaded(result.data?.cart));
        }
      case Fail():
        if (result.exception.toString().contains('404')) {
          emit(CartEmpty());
        } else if (result.exception is TokenException) {
          emit(NoUserLogged());
        } else {
          emit(
            CartError(getErrorMassageFromException(result.exception)),
          );
        }
    }
  }

  void addProductToCart(String productId) async {
    if (!isUserLoggedIn) {
      emit(NoUserLogged());
      return;
    }

    emit(AddToCartLoading());

    final result = await _addProductToCartUseCase.call(productId);

    switch (result) {
      case Success():
        emit(AddToCartSuccess());
      case Fail():
        if (result.exception is TokenException) {
          emit(NoUserLogged());
        } else {
          emit(
            AddToCartError(getErrorMassageFromException(result.exception)),
          );
        }
    }
  }

  void updateCartProductQuantity(String productId, int quantity) async {
    emit(UpdateCartProductQuantityLoading());

    final result =
        await _updateCartProductQuantityUseCase.call(productId, quantity);

    switch (result) {
      case Success():
        cart = result.data?.cart ?? Cart();
        emit(CartLoaded(result.data?.cart));
      case Fail():
        emit(
          CartError(getErrorMassageFromException(result.exception)),
        );
    }
  }

  void removeProductFromCart(String productId) async {
    emit(CartLoading());

    final result = await _removeProductFromCartUseCase.call(productId);

    switch (result) {
      case Success():
        getCartProducts();
      case Fail():
        emit(
          CartError(getErrorMassageFromException(result.exception)),
        );
    }
  }

  void clearCart() async {
    emit(CartLoading());

    final result = await _clearCartUseCase.call();

    switch (result) {
      case Success():
        getCartProducts();
      case Fail():
        emit(
          CartError(getErrorMassageFromException(result.exception)),
        );
    }
  }
}
