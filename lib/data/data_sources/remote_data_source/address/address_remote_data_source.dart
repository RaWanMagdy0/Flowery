import '../../../../core/api/api_result.dart';
import '../../../models/order/request/address_requests/add_address_request_body_model.dart';

abstract class AddressRemoteDataSource {
  Future<Result<bool>> addAddress(AddAddressRequestBody address);
}
