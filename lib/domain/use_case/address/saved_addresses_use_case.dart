import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../entities/address/saved_addresses_entity.dart';
import '../../repository/address/address_repository.dart';

@injectable
class SavedAddressesUseCase {
  AddressRepository repository;

  SavedAddressesUseCase(this.repository);

  Future<Result<List<SavedAddressesEntity>>> invoke() async {
    return await repository.getAllAddresses();
  }
}
