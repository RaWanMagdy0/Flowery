import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../core/api/api_const.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class BestSellerApi {
  factory BestSellerApi(Dio dio, {String baseUrl}) = BestSellerApiImpl;

  @GET('api/v1/best-seller')
  Future<Map<String, dynamic>> getBestSellers();
}

class BestSellerApiImpl implements BestSellerApi {
  final Dio _dio;
  final String baseUrl;

  BestSellerApiImpl(this._dio, {String? baseUrl})
      : baseUrl = baseUrl ?? ApiConstants.baseUrl;

  @override
  Future<Map<String, dynamic>> getBestSellers() async {
    final response = await _dio.get('${baseUrl}api/v1/best-seller');
    return response.data as Map<String, dynamic>;
  }
}