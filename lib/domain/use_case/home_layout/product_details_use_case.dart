import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/model/auth/response/produc_details_model.dart';
import 'package:flowery/domain/repository/home/home_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class ProductDetailsUseCase{
  HomeRepository repository;
  ProductDetailsUseCase({required this.repository});
  Future<Result<ProductDetailsModel?>>invoke({required String productId}){
    return repository.getProductDetails(productId: productId);
  }
}