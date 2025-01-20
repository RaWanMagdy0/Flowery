import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/entities/order/create_order/order_entity.dart';
import 'package:flowery/domain/repository/order/order_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrderHistoryUseCase {
  final OrderRepository orderRepository;
  GetOrderHistoryUseCase({required this.orderRepository});

  Future<Result<List<OrderEntity?>>> invoke() async {
    final result = await orderRepository.getOrdersHistory();
    return result;
  }
}
