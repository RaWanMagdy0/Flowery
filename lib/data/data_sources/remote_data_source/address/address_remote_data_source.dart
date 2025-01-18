import 'package:flowery/data/models/order/response/address_models/address_model.dart';

import '../../../../core/api/api_result.dart';
import '../../../models/order/request/address_requests/add_address_request_body_model.dart';
import '../../../models/order/response/create_order_response/order_response_model.dart';
import '../../../models/payment/request/payment_request_model.dart';
import '../../../models/payment/response/credit_payment_response_model.dart';

abstract class AddressRemoteDataSource {
  Future<Result<bool>> addAddress(AddAddressRequestBody address);

  Future<Result<List<AddressModel>>> getAllAddresses();

  Future<Result<dynamic>> deleteAddress(String addressId);
}
