import 'package:flowery/core/base/base_view_model.dart';
import 'package:flowery/domain/use_case/address/delete_address_use_case.dart';
import 'package:flowery/domain/use_case/address/saved_addresses_use_case.dart';
import 'package:flowery/presentation/addresses/saved_addresses/view_model/saved_addresses_states.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result.dart';
import '../../../../data/models/order/request/address_requests/add_address_request_body_model.dart';
import '../../../../domain/use_case/address/add_address_use_case.dart';

@injectable
class SavedAddressesViewModel extends BaseViewModel<SavedAddressesStates> {
  final SavedAddressesUseCase _savedAddressesUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;
  final AddAddressUseCase _addAddressUseCase;


  SavedAddressesViewModel(
      this._savedAddressesUseCase, this._deleteAddressUseCase,
  this._addAddressUseCase,

  )
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
  void addAddress(final AddAddressRequestBody body) async {
    emit(AddAddressesLoading());
    final result = await _addAddressUseCase.invoke(body);
    switch (result) {
      case Success():
        emit(AddAddressesSuccess());
        getAllAddresses();
      case Fail():
        emit(AddAddAddressFail(getErrorMassageFromException(result.exception)));
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
