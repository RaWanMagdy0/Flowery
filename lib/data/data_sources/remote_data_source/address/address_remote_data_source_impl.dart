import 'package:flowery/data/api/order_api/order_api_manager.dart';
import 'package:flowery/data/models/order/response/address_models/address_model.dart';
import 'package:flowery/data/models/order/response/address_models/address_response_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../core/api/execute_api_call.dart';
import '../../../../core/local/token_manger.dart';
import '../../../models/order/request/address_requests/add_address_request_body_model.dart';
import 'address_remote_data_source.dart';

@Injectable(as: AddressRemoteDataSource)
class AddressRemoteDataSourceImpl extends AddressRemoteDataSource {
  final OrderApiManger apiManger;

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

  @override
  Future<Result<List<AddressModel>>> getAllAddresses() async {
    return await executeApiCall<List<AddressModel>>(() async {
      var token = await _getToken();
      final response = await apiManger.getAllAddresses(token);
      return response.addresses ?? [];
    });
  }

  @override
  Future<Result<dynamic>> deleteAddress(String addressId) async {
    return await executeApiCall(
      () async {
        var token = await _getToken();
        return await apiManger.deleteAddress(addressId, token);
      },
    );
  }
}
