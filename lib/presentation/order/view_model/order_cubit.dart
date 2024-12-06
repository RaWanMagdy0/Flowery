import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/models/order/request/create_order_request/create_order_request.dart';
import 'package:flowery/domain/entities/address/create_order/order.dart';
import 'package:flowery/domain/use_case/order/create_order_use_case.dart';

import '../../../core/base/base_view_model.dart';
import 'order_state.dart';

class OrderCubit extends BaseViewModel<OrderState> {
  CreateOrderUseCase useCase;
  OrderCubit(this.useCase) : super(OrderInitialState());

  Future<void>createOrder(CreateOrderRequest createOrderRequest )async{
    emit(CheckoutLoadingState());
    var result=await useCase.invoke(createOrderRequest) ;
    switch(result){
      case Success<OrderEntity?>():
        emit(CheckoutSuccessState(orderEntity: result.data));
      case Fail<OrderEntity?>():
        emit(CheckoutErrorState(errorMessage: getErrorMassageFromException(result.exception)));
    }
  }

}
