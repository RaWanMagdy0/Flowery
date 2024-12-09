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
  OrderCubit(this.useCase) : super(OrderInitialState());

  OrderEntity? orderEntity;
  Future<void> createOrder(CreateOrderRequest createOrderRequest) async {
    emit(CheckoutLoadingState());

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

  int get subTotal => orderEntity?.totalPrice ?? 0;
  int get deliveryFee => 10;

  int get total => subTotal + deliveryFee;
}
