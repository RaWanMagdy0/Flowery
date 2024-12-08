import '../../../core/api/api_result.dart';
import '../../../data/models/order/request/address_requests/add_address_request_body_model.dart';
import '../../entities/address/saved_addresses_entity.dart';

abstract class AddressRepository {
  Future<Result<bool>> addAddress(AddAddressRequestBody address);

  Future<Result<List<SavedAddressesEntity>>> getAllAddresses();

  Future<Result<dynamic>> deleteAddress();
}
