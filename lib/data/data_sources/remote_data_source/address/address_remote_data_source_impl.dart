import 'package:flowery/data/api/Order_api/order_api_manager.dart';
import 'package:injectable/injectable.dart';

import 'address_remote_data_source.dart';

@Injectable(as: AddressRemoteDataSource)

class AddressRemoteDataSourceImpl extends AddressRemoteDataSource{
  OrderApiManger apiManger;
  AddressRemoteDataSourceImpl({required this.apiManger});


}