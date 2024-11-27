import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../data/models/produc_details_model.dart';
import '../../repository/home/home_repository.dart';

@injectable
class GetProductDetailsUseCase {
  HomeRepository repository;

  GetProductDetailsUseCase({required this.repository});

  Future<Result<ProductDetailsModel?>> invoke({required String productId}) {
    return repository.getProductDetails(productId: productId);
  }
}
