import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/repository/order/order_repository.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/order/request/create_order_request/create_order_request.dart';
import '../../entities/order/create_order/order_entity.dart';

@injectable
class CreateOrderUseCase{
  OrderRepository repository;
  CreateOrderUseCase({required this.repository});
  Future<Result<OrderEntity?>>invoke(CreateOrderRequest createOrderRequest)async{
    return await repository.createOrder(createOrderRequest);
  }
}