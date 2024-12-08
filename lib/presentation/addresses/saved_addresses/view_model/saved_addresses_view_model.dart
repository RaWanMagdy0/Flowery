import 'package:flowery/core/base/base_view_model.dart';
import 'package:flowery/domain/use_case/address/delete_address_use_case.dart';
import 'package:flowery/domain/use_case/address/saved_addresses_use_case.dart';
import 'package:flowery/presentation/addresses/saved_addresses/view_model/saved_addresses_states.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../domain/entities/address/saved_addresses_entity.dart';

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

  void deleteAddress() async {
    final result = await _deleteAddressUseCase.invoke();
    switch (result) {
      case Success():
        emit(DeleteAddressSuccess());
      case Fail():
        emit(DeleteAddressFailure());
    }
  }
}
