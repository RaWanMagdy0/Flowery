import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/repository/address/address_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteAddressUseCase {
  AddressRepository repository;
  DeleteAddressUseCase(this.repository);

  Future<Result<dynamic>> invoke(String addressId) async {
    return await repository.deleteAddress(addressId);
  }



}
