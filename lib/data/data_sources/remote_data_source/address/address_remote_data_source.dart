import 'package:flowery/data/models/order/response/address_models/address_model.dart';

import '../../../../core/api/api_result.dart';
import '../../../models/order/request/address_requests/add_address_request_body_model.dart';

abstract class AddressRemoteDataSource {
  Future<Result<bool>> addAddress(AddAddressRequestBody address);

  Future<Result<List<AddressModel>>> getAllAddresses();

  Future<Result<dynamic>> deleteAddress(String addressId); // Add more methods for other CRUD operations on addresses
}
