import 'package:flowery/domain/use_case/order/get_order_history_use_case.dart';
import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../../core/base/base_view_model.dart';
import '../../../data/models/order/request/create_order_request/create_order_request.dart';
import '../../../data/models/payment/request/payment_request_model.dart';
import '../../../domain/entities/order/create_order/order_entity.dart';
import '../../../domain/use_case/order/create_order_use_case.dart';
import '../../../domain/use_case/order/payment/cash_payment_use_case.dart';
import '../../../domain/use_case/order/payment/credit_payment_use_case.dart';
import 'order_state.dart';

@injectable
class OrderCubit extends BaseViewModel<OrderState> {
  CreateOrderUseCase useCase;
  GetOrderHistoryUseCase historyUseCase;
  final CashPaymentUseCase _cashPaymentUseCase;
  final CreditPaymentUseCase _creditPaymentUseCase;

  OrderCubit(this.useCase, this.historyUseCase, this._cashPaymentUseCase,
      this._creditPaymentUseCase)
      : super(OrderInitialState());

  OrderEntity? orderEntity;

  Future<void> createOrder(CreateOrderRequest createOrderRequest) async {
    emit(OrderLoadingState());
    var result = await useCase.invoke(createOrderRequest);
    switch (result) {
      case Success<OrderEntity?>():
        orderEntity = result.data;

        emit(CheckoutSuccessState(orderEntity: orderEntity));
      case Fail<OrderEntity?>():
        emit(CheckoutErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }

  Future<void> getOrdersHistory() async {
    emit(OrderLoadingState());
    var result = await historyUseCase.invoke();
    switch (result) {
      case Success():
        emit(GetOrdersSuccessState(orders: result.data ?? []));
      case Fail():
        emit(GetOrdersErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }

  Future<void> handlePaymentMethod(
      ShippingAddressRequest shippingAddressRequest, bool isCash) async {
    emit(PaymentLoadingState());

    var result = isCash
        ? await _cashPaymentUseCase.invoke(shippingAddressRequest)
        : await _creditPaymentUseCase.invoke(shippingAddressRequest);

    print("Payment result: $result");

    if (result is Success<OrderEntity?>) {
      orderEntity = result.data;
      print("OrderEntity after payment: $orderEntity");

      if (orderEntity != null) {
        emit(CheckoutSuccessState(orderEntity: orderEntity));
      } else {
        emit(PaymentErrorState("Order data is missing after payment."));
      }
    } else if (result is Fail<OrderEntity?>) {
      emit(PaymentErrorState(getErrorMassageFromException(result.exception)));
    }
  }


}
