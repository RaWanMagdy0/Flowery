import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../core/api/execute_api_call.dart';
import '../../../../core/local/token_manger.dart';
import '../../../api/cart_api/cart_api_manager.dart';
import '../../../models/cart/cart_products_response_model.dart';
import 'cart_remote_data_source.dart';

@Injectable(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final CartApiManager apiManager;

  CartRemoteDataSourceImpl(this.apiManager);

  @override
  Future<Result<CartProductsResponseModel>> getCartProducts() async {
    return await executeApiCall<CartProductsResponseModel>(() async {
      String? token = await TokenManager.getToken();

      if (token == null || token.isEmpty) {
        final tokenException =
            Exception('Token is empty, please login and try again');
        throw tokenException;
        // return Fail(exception: tokenException);
      }

      token = 'Bearer $token';

      return await apiManager.getCartProducts(token);
    });
  }
}
