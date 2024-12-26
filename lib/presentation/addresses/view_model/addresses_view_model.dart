import 'package:flowery/domain/use_case/order/payment/cash_payment_use_case.dart';
import 'package:flowery/domain/use_case/order/payment/credit_payment_use_case.dart';

import '../../../core/api/api_result.dart';
import '../../../data/models/payment/request/payment_request_model.dart';
import '../../../domain/use_case/address/add_address_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/base/base_view_model.dart';
import '../../../data/models/order/request/address_requests/add_address_request_body_model.dart';

part 'addresses_state.dart';

@injectable
class AddressesCubit extends BaseViewModel<AddressesState> {
  final AddAddressUseCase _addAddressUseCase;
  AddressesCubit(
    this._addAddressUseCase,
  ) : super(AddressesInitial());

  void AddAddress(final AddAddressRequestBody body) async {
    emit(AddAddressesLoading());

    final result = await _addAddressUseCase.invoke(body);

    switch (result) {
      case Success():
        emit(AddAddressesSuccess());

      case Fail():
        emit(AddAddAddressFail(getErrorMassageFromException(result.exception)));
    }
  }
}
