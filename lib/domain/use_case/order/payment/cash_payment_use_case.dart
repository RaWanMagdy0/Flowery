import 'package:flowery/data/models/payment/request/payment_request_model.dart';
import 'package:flowery/domain/entities/order/payment/cash_payment_entity.dart';
import 'package:flowery/domain/repository/address/address_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../entities/order/create_order/order_response_entity.dart';
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
