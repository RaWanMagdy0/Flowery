import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/model/home/produc_details_model.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/home/home_data_entity.dart';
import '../../../domain/repository/home/home_repository.dart';
import '../../data_source/remote_data_source/home/home_remote_data_source.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource onlineDataSource;

  HomeRepositoryImpl({required this.onlineDataSource});

  @override
  Future<Result<HomeData?>> getHomeData() async {
    final result = await onlineDataSource.getHomeData();

    switch (result) {
      case Success():
        return Success<HomeData>(data: result.data?.toEntity());
      case Fail():
        return Fail(exception: result.exception);
    }
  }

  @override
  Future<Result<ProductDetailsModel?>> getProductDetails(
      {required String productId}) {
    return onlineDataSource.getProductDetails(productId: productId);
  }
}
