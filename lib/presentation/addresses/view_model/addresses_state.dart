part of 'addresses_view_model.dart';

sealed class AddressesState {}

final class AddressesInitial extends AddressesState {}

final class AddAddressesLoading extends AddressesState {}

final class AddAddressesSuccess extends AddressesState {}

final class AddAddAddressFail extends AddressesState {
  final String message;

  AddAddAddressFail(this.message);
}
