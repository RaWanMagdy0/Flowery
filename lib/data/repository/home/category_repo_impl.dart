import 'dart:developer';

import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../domain/entities/home_layout/product_details_entity.dart';
import '../../../domain/entities/home/home_category_entity.dart';
import '../../../domain/repository/home/category_repository.dart';
import '../../../presentation/home_layout/screens/categories/view_model/categories_view_model.dart';
import '../../data_sources/remote_data_source/home/category/category_remote_data_source.dart';

@Injectable(as: CategoryRepository)
class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRepositoryImpl({required this.categoryRemoteDataSource});

  @override
  Future<Result<List<HomeCategory>?>> getAllCategories() async {
    final result = await categoryRemoteDataSource.getAllCategories();
    switch (result) {
      case Success():
        final categories = result.data?.categories
                ?.map(
                  (model) => model.toEntity(),
                )
                .toList() ??
            [];

        return Success<List<HomeCategory>?>(data: categories);
      case Fail():
        return Fail(exception: result.exception);
    }
  }

  @override
  Future<Result<List<ProductEntity>?>> getCategoryProducts() async {
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

  @override
  Future<Result<List<ProductEntity?>>> getSortedProducts(
      ProductFilterOption sort) async {
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
        return Success<List<ProductEntity?>>(data: products);
      case Fail():
        return Fail(exception: result.exception);
    }
  }
}
