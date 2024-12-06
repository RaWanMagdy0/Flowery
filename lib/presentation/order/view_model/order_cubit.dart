import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../core/base/base_view_model.dart';
import '../../../data/models/order/request/create_order_request/create_order_request.dart';
import '../../../domain/entities/address/create_order/order.dart';
import '../../../domain/use_case/order/create_order_use_case.dart';
import 'order_state.dart';

@injectable
class OrderCubit extends BaseViewModel<OrderState> {
  CreateOrderUseCase useCase;
  OrderCubit(this.useCase) : super(OrderInitialState());

  Future<void> createOrder(CreateOrderRequest createOrderRequest) async {
    emit(CheckoutLoadingState());
    var result = await useCase.invoke(createOrderRequest);
    switch (result) {
      case Success<OrderEntity?>():
        emit(CheckoutSuccessState(orderEntity: result.data));
      case Fail<OrderEntity?>():
        emit(CheckoutErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }
}
