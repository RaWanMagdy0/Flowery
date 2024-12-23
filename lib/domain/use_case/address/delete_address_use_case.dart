import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../repository/address/address_repository.dart';

@injectable
class DeleteAddressUseCase {
  AddressRepository repository;
  DeleteAddressUseCase(this.repository);

  Future<Result<dynamic>> invoke(String addressId) async {
    return await repository.deleteAddress(addressId);
  }
}
