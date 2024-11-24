import 'package:flowery/data/models/occasions/occasions_response_model.dart';
import 'package:flowery/domain/repository/home/occastions/occastons_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_result.dart';

@Injectable()
class OccasionsUseCase {
  OccasionsRepository occasionsRepository;

  OccasionsUseCase(this.occasionsRepository);

  Future<Result<List<Occasions>?>> invoke() {
    return occasionsRepository.GetOccasions();
  }
}
