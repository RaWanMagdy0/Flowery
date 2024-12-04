import '../../../core/base/base_view_model.dart';

part 'addresses_state.dart';

class AddressesCubit extends BaseViewModel<AddressesState> {
  AddressesCubit() : super(AddressesInitial());
}
