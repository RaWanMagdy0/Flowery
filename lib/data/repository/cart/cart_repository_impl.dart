import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../domain/entities/cart/cart_response_entity.dart';
import '../../../domain/repository/cart/cart_repository.dart';
import '../../data_sources/remote_data_source/cart/cart_remote_data_source.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<CartResponse?>> getCartProducts() async {
    final response = await remoteDataSource.getCartProducts();

    switch (response) {
      case Success():
        return Success(data: response.data?.toEntity());

      case Fail():
        return Fail(exception: response.exception);
    }
  }

  @override
  Future<Result<bool?>> addProductToCart(String productId) async {
    final response = await remoteDataSource.addProductToCart(productId);

    switch (response) {
      case Success():
        return Success(data: true);

      case Fail():
        return Fail(exception: response.exception);
    }
  }

  @override
  Future<Result<CartResponse?>> updateCartProductQuantity(
      String productId, int quantity) async {
    final response =
        await remoteDataSource.updateCartProductQuantity(productId, quantity);

    switch (response) {
      case Success():
        return Success(data: response.data?.toEntity());

      case Fail():
        return Fail(exception: response.exception);
    }
  }

  @override
  Future<Result<bool?>> removeProductFromCart(String productId) async {
    final response = await remoteDataSource.removeProductFromCart(productId);

    switch (response) {
      case Success():
        return Success(data: true);

      case Fail():
        return Fail(exception: response.exception);
    }
  }

  @override
  Future<Result<bool?>> clearCart() async {
    final response = await remoteDataSource.clearCart();

    switch (response) {
      case Success():
        return Success(data: true);

      case Fail():
        return Fail(exception: response.exception);
    }
  }
}
