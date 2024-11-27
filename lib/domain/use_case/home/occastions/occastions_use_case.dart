import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../data/models/home/occasions/occasions_response_model.dart';
import '../../../repository/home/occasions_repository.dart';

@injectable
class OccasionsUseCase {
  OccasionsRepository occasionsRepository;

  OccasionsUseCase(this.occasionsRepository);

  Future<Result<List<Occasions>?>> invoke() async {
    return await occasionsRepository.getAllOccasions();
  }
}
