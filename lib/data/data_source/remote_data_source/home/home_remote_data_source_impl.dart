import 'package:injectable/injectable.dart';

import '../../../api/home_api/home_api_manager.dart';
import 'home_remote_data_source.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  HomeApiManger apiManger;

  HomeRemoteDataSourceImpl({required this.apiManger});
}
