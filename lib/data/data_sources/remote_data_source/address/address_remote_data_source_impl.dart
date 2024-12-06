import 'package:flowery/data/api/order_api/order_api_manager.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../core/api/execute_api_call.dart';
import '../../../../core/local/token_manger.dart';
import '../../../models/order/request/address_requests/add_address_request_body_model.dart';
import 'address_remote_data_source.dart';

@Injectable(as: AddressRemoteDataSource)
class AddressRemoteDataSourceImpl extends AddressRemoteDataSource {
  OrderApiManger apiManger;

  AddressRemoteDataSourceImpl(this.apiManger);

  Future<String> _getToken() async {
    var token = await TokenManager.getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token is missing. Please login again.");
    }
    return 'Bearer $token';
  }

  @override
  Future<Result<bool>> addAddress(AddAddressRequestBody address) async {
    return await executeApiCall<bool>(() async {
      var token = await _getToken();
      await apiManger.addAddress(token, address);

      return true;
    });
  }
}
