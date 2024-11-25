import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../core/api/execute_api_call.dart';
import '../../api/best_seller_api.dart';
import '../../models/best_seller_model.dart';

@injectable
class BestSellerRemoteDataSource {
  final BestSellerApi _api;

  BestSellerRemoteDataSource(this._api);

  Future<Result<List<BestSellerModel>>> getBestSellers() {
    return executeApiCall(apiCall: () async {
      final response = await _api.getBestSellers();
      return response.bestSellers!;
    });
  }
}
