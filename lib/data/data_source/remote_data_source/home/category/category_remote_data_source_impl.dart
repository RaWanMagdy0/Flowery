import 'dart:developer';

import 'package:flowery/data/data_source/remote_data_source/home/category/category_remote_data_source.dart';
import 'package:flowery/data/models/home/home_category_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_result.dart';
import '../../../../../core/api/execute_api_call.dart';
import '../../../../api/home_api/home_api_manager.dart';
import '../../../../model/auth/response/produc_details_model.dart';

@Injectable(as: CategoryRemoteDataSource)
class CategoryRemoteDataSourceImpl extends CategoryRemoteDataSource {
  HomeApiManger apiManger;

 CategoryRemoteDataSourceImpl({required this.apiManger});

  @override
  Future<Result<HomeCategoryModel?>> getAllCategories() {
    return executeApiCall<HomeCategoryModel?>(apiCall: () async {
      return await apiManger.getAllCategories();
    });
  }

  @override
  Future<Result<List<ProductModel>?>> getCategoriesProduct() {
    return executeApiCall(apiCall: () async {
      final response = await apiManger.getCategoriesProduct();
      final data = response.products;
      log('data: $data', name: 'CategoryRemoteDataSourceImpl');
      return data!;
    });
  }

}
