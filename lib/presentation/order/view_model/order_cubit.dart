import 'package:flowery/domain/use_case/order/get_order_history_use_case.dart';
import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../../core/base/base_view_model.dart';
import '../../../data/models/order/request/create_order_request/create_order_request.dart';
import '../../../domain/entities/order/create_order/order_entity.dart';
import '../../../domain/use_case/order/create_order_use_case.dart';
import 'order_state.dart';

@injectable
class OrderCubit extends BaseViewModel<OrderState> {
  CreateOrderUseCase useCase;
  GetOrderHistoryUseCase historyUseCase;
  OrderCubit(this.useCase, this.historyUseCase) : super(OrderInitialState());

  OrderEntity? orderEntity;
  Future<void> createOrder(CreateOrderRequest createOrderRequest) async {
    emit(OrderLoadingState());

    var result = await useCase.invoke(createOrderRequest);
    switch (result) {
      case Success<OrderEntity?>():
        orderEntity = result.data!;
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
      case Success<OrderEntity?>():
        emit(GetOrdersSuccessState());
      case Fail<OrderEntity?>():
        emit(GetOrdersErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }
}
