import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../data/models/order/request/address_requests/add_address_request_body_model.dart';
import '../../repository/address/address_repository.dart';

@injectable
class AddAddressUseCase {
  AddressRepository repository;

  AddAddressUseCase(this.repository);

  Future<Result<bool>> invoke(AddAddressRequestBody address) async {
    return await repository.addAddress(address);
  }
}
