import 'package:flowery/data/models/order/response/create_order_response/order_model.dart';
import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../../domain/entities/order/create_order/order_entity.dart';
import '../../../domain/entities/order/create_order/order_item_entity.dart';
import '../../../domain/repository/order/order_repository.dart';
import '../../data_sources/remote_data_source/order/order_remote_data_source.dart';
import '../../models/order/request/create_order_request/create_order_request.dart';

@Injectable(as: OrderRepository)
class OrderRepositoryImpl extends OrderRepository {
  final OrderRemoteDataSource dataSource;

  OrderRepositoryImpl(this.dataSource);

  @override
  Future<Result<OrderEntity?>> createOrder(
      CreateOrderRequest createOrderRequest) async {
    final response = await dataSource.createOrder(createOrderRequest);

    switch (response) {
      case Success():
        return Success(data: response.data?.toEntity());

      case Fail():
        return Fail(exception: response.exception);
    }
  }

  @override
  Future<Result<OrderItemEntity?>> getOrdersHistory() async {
    final response = await dataSource.getOrdersHistory();
    switch (response) {
      case Success():
        return Success(data: response.data?.toOrderItems());
      case Fail():
        return Fail(exception: response.exception);
    }
  }
}
