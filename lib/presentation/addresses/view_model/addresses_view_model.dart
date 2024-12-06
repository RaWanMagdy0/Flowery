import 'package:injectable/injectable.dart';

import '../../../core/base/base_view_model.dart';

part 'addresses_state.dart';

@injectable
class AddressesCubit extends BaseViewModel<AddressesState> {
  AddressesCubit() : super(AddressesInitial());
}
