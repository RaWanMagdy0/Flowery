import 'package:flowery/data/data_sources/remote_data_source/address/address_remote_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repository/address/address_repository.dart';
@Injectable(as:AddressRepository)
class AddressRepositoryImpl extends AddressRepository{
  AddressRemoteDataSource dataSource;
  AddressRepositoryImpl({required this.dataSource});
}