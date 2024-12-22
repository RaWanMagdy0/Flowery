import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../domain/entities/best_seller_entity.dart';
import '../../../domain/entities/home/home_data_entity.dart';
import '../../../domain/entities/home_layout/product_details_entity.dart';
import '../../../domain/repository/home/home_repository.dart';
import '../../data_sources/remote_data_source/home/home/home_remote_data_source.dart';
import '../../models/produc_details_model.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource onlineDataSource;

  HomeRepositoryImpl({required this.onlineDataSource});

  @override
  Future<Result<HomeData?>> getHomeData() async {
    final result = await onlineDataSource.getHomeData();

    switch (result) {
      case Success():
        final data = result.data?.toEntity();
        return Success<HomeData>(data: data);
      case Fail():
        return Fail(exception: result.exception);
    }
  }

  @override
  Future<Result<ProductDetailsModel?>> getProductDetails(
      {required String productId}) {
    return onlineDataSource.getProductDetails(productId: productId);
  }

  @override
  Future<Result<List<BestSeller>>> getBestSellerProducts() async {
    final result = await onlineDataSource.getBestSellerProducts();

    switch (result) {
      case Success():
        final products = result.data
            ?.map((model) => BestSeller(
          id: model.id,
          title: model.title,
          imageUrl: model.imageUrl,
          price: model.price,
          priceAfterDiscount: model.priceAfterDiscount,
          occasionid: model.occasionid,
        ))
            .toList() ??
            [];

        return Success<List<BestSeller>>(data: products);
      case Fail():
        return Fail(exception: result.exception);
    }
  }

  @override
  Future<Result<List<ProductEntity>?>> searchProducts(String query) async {
    final result = await onlineDataSource.searchProducts(query);

    switch (result) {
      case Success():
        final products = result.data?.products
            ?.map((model) => model.toEntity())
            .toList();
        return Success(data: products);
      case Fail():
        return Fail(exception: result.exception);
    }
  }
}
