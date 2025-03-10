import 'package:flowery/domain/entities/pending_orders/order_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../core/base/base_view_model.dart';
import '../../../../domain/use_case/order/pending_orders_use_case.dart';
import 'map_states.dart';

@injectable
class OrderDetailsCubit extends BaseViewModel<PendingOrderState> {
  GetPendingOrderUseCase orderUseCase;
  OrderDetailsCubit(
      this.orderUseCase)
      : super(OrderStateInitial());

  List<OrderEntityDriver?> orderEntity = [];
  int currentStep = 1;


  Future<void> getPendingOrders() async {
    if (isClosed) return;
    emit(OrderStateLoading());
    var result = await orderUseCase.invoke();
    if (isClosed) return;
    switch (result) {
      case Success():
        orderEntity = result.data ?? [];
        emit(PendingGetOrdersSuccessState(orders: result.data ?? []));
      case Fail():
        emit(PendingGetOrdersErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }


}

