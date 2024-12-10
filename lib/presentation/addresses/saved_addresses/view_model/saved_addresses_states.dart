import '../../../../domain/entities/address/saved_addresses_entity.dart';

sealed class SavedAddressesStates {}

final class SavedAddressesInitial extends SavedAddressesStates {}

final class SavedAddressesLoading extends SavedAddressesStates {}

final class SavedAddressesSuccess extends SavedAddressesStates {
  final List<SavedAddressesEntity> addresses;
  SavedAddressesSuccess(this.addresses);
}

final class SavedAddressesFailure extends SavedAddressesStates {}

// delete Address

final class DeleteAddressSuccess extends SavedAddressesStates {}

final class DeleteAddressFailure extends SavedAddressesStates {
  final String message;
  DeleteAddressFailure(this.message);

}
