import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../entities/home/home_data_entity.dart';
import '../../repository/home/home_repository.dart';

@injectable
class GetHomeDataUseCase {
  final HomeRepository _homeRepository;

  GetHomeDataUseCase(this._homeRepository);

  Future<Result<HomeData?>> invoke() {
    return _homeRepository.getHomeData();
  }
}
