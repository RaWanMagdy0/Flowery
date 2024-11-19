import '../../../core/api/api_result.dart';
import '../../entities/home/home_data_entity.dart';

abstract class HomeRepository {
  Future<Result<HomeData?>> getHomeData();
}
