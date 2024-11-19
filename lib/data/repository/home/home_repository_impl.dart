import 'package:injectable/injectable.dart';

import '../../../domain/repository/home/home_repository.dart';
import '../../data_source/remote_data_source/home/home_remote_data_source.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource onlineDataSource;

  HomeRepositoryImpl({required this.onlineDataSource});
}
