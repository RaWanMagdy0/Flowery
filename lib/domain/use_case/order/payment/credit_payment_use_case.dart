import 'package:flowery/data/models/payment/request/payment_request_model.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result.dart';
import '../../../entities/order/payment/credit_card_entity.dart';
import '../../../repository/order/order_repository.dart';

@injectable
class CreditPaymentUseCase {
  OrderRepository repository;
  CreditPaymentUseCase(this.repository);

  Future<Result<CreditPaymentEntity?>> invoke(
      ShippingAddressRequest shippingAddressRequest) async {
    return await repository.creditCardPaymentMethod(shippingAddressRequest);
  }
}
