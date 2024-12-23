import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../domain/entities/address/saved_addresses_entity.dart';
import '../../../domain/repository/address/address_repository.dart';
import '../../data_sources/remote_data_source/address/address_remote_data_source.dart';
import '../../models/order/request/address_requests/add_address_request_body_model.dart';

@Injectable(as: AddressRepository)
class AddressRepositoryImpl extends AddressRepository {
  AddressRemoteDataSource dataSource;

  AddressRepositoryImpl({required this.dataSource});

  @override
  Future<Result<bool>> addAddress(AddAddressRequestBody address) async {
    return await dataSource.addAddress(address);
  }

/**********************
  @override
  Future<Result<List<SavedAddressesEntity>>> getAllAddresses() async {
    final result = await dataSource.getAllAddresses();

    if (result is Success<List<AddressModel>>) {
      // Map AddressModel to SavedAddressesEntity
      final entities = result.data?.map((model) => model.toEntity()).toList();
      return Success();
    } else if (result is Fail<List<AddressModel>>) {
      return Fail();
    } else {
      return Fail();
    }
  }
******************/
  @override
  Future<Result<List<SavedAddressesEntity>>> getAllAddresses() async {
    final result = await dataSource.getAllAddresses();

    switch (result) {
      case Success():
        final entities = result.data?.map((model) => model.toEntity()).toList();
        return Success(data: entities);
      case Fail():
        return Fail(exception: result.exception);
    }
  }

  @override
  Future<Result<dynamic>> deleteAddress(String addressId) async {
    var response = await dataSource.deleteAddress(addressId);
    switch (response) {
      case Success():
        return Success(data: true);

      case Fail():
        return Fail(exception: response.exception);
    }
  }
}
