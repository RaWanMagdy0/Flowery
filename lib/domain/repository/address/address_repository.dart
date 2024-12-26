import 'package:flowery/domain/entities/order/create_order/order_response_entity.dart';

import '../../../core/api/api_result.dart';
import '../../../data/models/order/request/address_requests/add_address_request_body_model.dart';
import '../../../data/models/payment/request/payment_request_model.dart';
import '../../entities/address/saved_addresses_entity.dart';
import '../../entities/order/payment/cash_payment_entity.dart';
import '../../entities/order/payment/credit_card_entity.dart';

abstract class AddressRepository {
  Future<Result<bool>> addAddress(AddAddressRequestBody address);

  Future<Result<List<SavedAddressesEntity>>> getAllAddresses();

  Future<Result<dynamic>> deleteAddress(String addressId);
}
