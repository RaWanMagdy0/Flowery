import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../domain/entities/cart/cart_product_entity.dart';
import '../../../domain/repository/cart/cart_repository.dart';
import '../../data_sources/remote_data_source/cart/cart_remote_data_source.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<List<CartProduct>?>> getCartProducts() async {
    final response = await remoteDataSource.getCartProducts();

    switch (response) {
      case Success():
        final List<CartProduct>? products =
            response.data?.cart?.map((e) => e.toEntity()).toList();
        return Success(data: products);

      case Fail():
        return Fail(exception: response.exception);
    }
  }
}
