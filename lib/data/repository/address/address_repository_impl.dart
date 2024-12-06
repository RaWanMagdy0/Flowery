import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
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
}
