import 'package:flowery/core/base/base_view_model.dart';
import 'package:flowery/domain/use_case/address/delete_address_use_case.dart';
import 'package:flowery/domain/use_case/address/saved_addresses_use_case.dart';
import 'package:flowery/presentation/addresses/saved_addresses/view_model/saved_addresses_states.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';

@injectable
class SavedAddressesViewModel extends BaseViewModel<SavedAddressesStates> {
  final SavedAddressesUseCase _savedAddressesUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;

  SavedAddressesViewModel(
      this._savedAddressesUseCase, this._deleteAddressUseCase)
      : super(SavedAddressesInitial());

  void getAllAddresses() async {
    emit(SavedAddressesLoading());
    final result = await _savedAddressesUseCase.invoke();
    switch (result) {
      case Success():
        emit(SavedAddressesSuccess(result.data ?? []));
      case Fail():
        emit(SavedAddressesFailure());
    }
  }

  void deleteAddress(String addressId) async {
    emit(SavedAddressesLoading());
    final result = await _deleteAddressUseCase.invoke(addressId);
    switch (result) {
      case Success():
        emit(DeleteAddressSuccess());
        getAllAddresses();
        break;

      case Fail():
        emit(DeleteAddressFailure(
            getErrorMassageFromException(result.exception)));
    }
  }
}
