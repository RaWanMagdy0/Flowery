import 'package:flowery/domain/entities/order/create_order/order_entity.dart';
import 'package:flowery/domain/entities/pending_orders/order_entity.dart';
import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../../domain/entities/order/payment/credit_card_entity.dart';
import '../../../domain/repository/order/order_repository.dart';
import '../../data_sources/remote_data_source/order/order_remote_data_source.dart';
import '../../models/order/request/create_order_request/create_order_request.dart';
import '../../models/payment/request/payment_request_model.dart';

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
  Future<Result<List<OrderEntity?>>> getOrdersHistory() async {
    final response = await dataSource.getOrdersHistory();
    switch (response) {
      case Success():
        final entities =
            response.data?.map((model) => model?.toEntity()).toList();
        return Success(data: entities);
      case Fail():
        return Fail(exception: response.exception);
    }
  }

  @override
  Future<Result<OrderEntity?>> cashPaymentMethod(
      ShippingAddressRequest shippingAddressRequest) async {
    final response = await dataSource.cashPaymentMethod(shippingAddressRequest);
    switch (response) {
      case Success():
        return Success(data: response.data?.toEntity());
      case Fail():
        return Fail(exception: response.exception);
    }
  }

  @override
  Future<Result<CreditPaymentEntity?>> creditCardPaymentMethod(
      ShippingAddressRequest shippingAddressRequest) async {
    final response =
        await dataSource.creditCardPaymentMethod(shippingAddressRequest);
    switch (response) {
      case Success():
        return Success(data: response.data?.toEntity());
      case Fail():
        return Fail(exception: response.exception);
    }
  }

  @override
  Future<Result<List<OrderEntityDriver?>>> getPendingOrders() async {
    final response = await dataSource.getPendingOrders();
    switch (response) {
      case Success():
        final entities =
            response.data?.map((model) => model?.toEntity()).toList();
        return Success(data: entities);
      case Fail():
        return Fail(exception: response.exception);
    }
  }
}
