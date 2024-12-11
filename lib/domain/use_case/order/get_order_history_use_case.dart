import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/entities/order/create_order/order_entity.dart';
import 'package:flowery/domain/repository/order/order_repository.dart';
import 'package:injectable/injectable.dart';

import '../../entities/order/create_order/order_item_entity.dart';
@injectable
class GetOrderHistoryUseCase{
  OrderRepository orderRepository;
  GetOrderHistoryUseCase({required this.orderRepository});
  Future<Result<OrderItemEntity?>>invoke()async{
    return orderRepository.getOrdersHistory();

  }
}