import 'dart:developer';

import 'package:flowery/data/data_source/remote_data_source/home/category/category_remote_data_source.dart';
import 'package:flowery/data/models/home/home_category_model.dart';
import 'package:flowery/domain/repository/category_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../domain/entities/home_layout/product_details_entity.dart';

@Injectable(as: CategoryRepository)
class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRepositoryImpl({required this.categoryRemoteDataSource});

  @override
  Future<Result<List<HomeCategoryModel>?>> getAllCategories() async {
    final result = await categoryRemoteDataSource.getAllCategories();
    switch (result) {
      case Success():
        return Success<List<HomeCategoryModel>?>();
      case Fail():
        return Fail(exception: result.exception);
    }
  }

  @override
  Future<Result<List<ProductEntity>?>> getCategoriesProduct() async {
    final result = await categoryRemoteDataSource.getCategoriesProduct();
    switch (result) {
      case Success():
        log('data: ${result.data}', name: 'Occasions Repository');

        final products = result.data
                ?.map((model) => ProductEntity(
                      id: model.id,
                      title: model.title,
                      imgCover: model.imgCover,
                      price: model.price,
                      priceAfterDiscount: model.priceAfterDiscount,
                      occasion: model.occasion,
                      category: model.category,
                      description: model.description,
                      images: model.images,
                      quantity: model.quantity,
                      slug: model.slug,
                    ))
                .toList() ??
            [];
        log('products: ${result.data}',
            name: 'Category Repository -- Products');
        return Success<List<ProductEntity>?>(data: products);
      case Fail():
        return Fail(exception: result.exception);
    }
  }
}
