import 'dart:developer';

import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_result.dart';
import '../../../../../core/api/execute_api_call.dart';
import '../../../../api/home_api/home_api_manager.dart';
import '../../../../models/home/category/all_categories_response_model.dart';
import '../../../../models/produc_details_model.dart';
import 'category_remote_data_source.dart';

@Injectable(as: CategoryRemoteDataSource)
class CategoryRemoteDataSourceImpl extends CategoryRemoteDataSource {
  HomeApiManger apiManger;

  CategoryRemoteDataSourceImpl({required this.apiManger});

  @override
  Future<Result<AllCategoriesResponseModel>> getAllCategories() {
    return executeApiCall(
          () async {
        return await apiManger.getAllCategories();
      },
    );
  }

  @override
  Future<Result<List<ProductModel>?>> getCategoriesProduct() {
    return executeApiCall(() async {
      final response = await apiManger.getCategoryProducts();
      final data = response.products;
      log('data: $data', name: 'CategoryRemoteDataSourceImpl');
      return data!;
    });
  }

  @override
  Future<Result<List<ProductModel>>> getSortedProducts(String sort) {
    return executeApiCall(() async {
      final response = await apiManger.getSortedProducts(sort);
      final data = response?.products;
      log('Sorted products: $data', name: 'CategoryRemoteDataSource');
      return data!;
    });
  }
}
