import 'package:flowery/domain/entities/address/saved_addresses_entity.dart';
import 'package:flowery/domain/repository/address/address_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../repository/order/order_repository.dart';

@injectable
class SavedAddressesUseCase {
  AddressRepository repository;

  SavedAddressesUseCase(this.repository);

  Future<Result<List<SavedAddressesEntity>>> invoke() async {
    return await repository.getAllAddresses();
  }
}
