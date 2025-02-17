import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../entities/pending_orders/order_entity.dart';
import '../../repository/order/order_repository.dart';
@injectable
class GetPendingOrderUseCase {
  final OrderRepository orderRepository;
  GetPendingOrderUseCase({required this.orderRepository});

  Future<Result<List<OrderEntityDriver?>>> invoke() async {
    final result = await orderRepository.getPendingOrders();
    return result;
  }
}
