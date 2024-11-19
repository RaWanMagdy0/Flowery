import '../../../../core/api/api_result.dart';
import '../../../models/home/home_data_model.dart';

abstract class HomeRemoteDataSource {
  Future<Result<HomeDataModel>> getHomeData();
}
