import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../data/model/auth/response/produc_details_model.dart';
import '../../repository/home/home_repository.dart';

@injectable
class ProductDetailsUseCase {
  HomeRepository repository;
  ProductDetailsUseCase({required this.repository});
  Future<Result<ProductDetailsModel?>> invoke({required String productId}) {
    return repository.getProductDetails(productId: productId);
  }
}
