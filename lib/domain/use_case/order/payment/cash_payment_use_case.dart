import 'package:flowery/data/models/payment/request/payment_request_model.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result.dart';
import '../../../entities/order/create_order/order_entity.dart';
import '../../../repository/order/order_repository.dart';

@injectable
class CashPaymentUseCase {
  OrderRepository repository;
  CashPaymentUseCase(this.repository);

  Future<Result<OrderEntity?>> invoke(
      ShippingAddressRequest shippingAddressRequest) async {
    return await repository.cashPaymentMethod(shippingAddressRequest);
  }
}
