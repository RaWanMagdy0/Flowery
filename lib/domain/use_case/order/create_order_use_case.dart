import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../data/models/order/request/create_order_request/create_order_request.dart';
import '../../entities/order/create_order/order_entity.dart';
import '../../repository/order/order_repository.dart';

@injectable
class CreateOrderUseCase {
  OrderRepository repository;
  CreateOrderUseCase({required this.repository});
  Future<Result<OrderEntity?>> invoke(
      CreateOrderRequest createOrderRequest) async {
    return await repository.createOrder(createOrderRequest);
  }
}
