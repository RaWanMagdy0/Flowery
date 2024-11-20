import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/model/auth/response/ProductDetailsModel.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repository/home/home_repository.dart';
import '../../data_source/remote_data_source/home/home_remote_data_source.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource onlineDataSource;

  HomeRepositoryImpl({required this.onlineDataSource});

  @override
  Future<Result<ProductDetailsModel?>> getProductDetails({required String productId}) {
   return onlineDataSource.getProductDetails(productId: productId);
  }
}
