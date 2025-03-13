import 'package:flowery/core/api/api_result.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repository/fire_base_order/fire_store_rder_repository.dart';
import '../../entities/fire_base/fire_base_order.dart';

@injectable
class FireBaseOrderUseCase {
  final FireStoreOrderRepository repository;

  FireBaseOrderUseCase(this.repository);

  Future<Result<FireBaseOrder?>> call(String orderId)async {
    return await repository.fetchOrderDetails(orderId);
  }
}
