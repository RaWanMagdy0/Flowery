import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../data/models/occasions/occasions_response_model.dart';
import '../../../repository/home/occastions/occastons_repository.dart';

@Injectable()
class OccasionsUseCase {
  OccasionsRepository occasionsRepository;

  OccasionsUseCase(this.occasionsRepository);

  Future<Result<List<Occasions>?>> invoke() {
    return occasionsRepository.getOccasions();
  }
}
