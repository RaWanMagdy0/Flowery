import '../../../core/base/base_view_model.dart';

part 'checkout_state.dart';

class CheckoutCubit extends BaseViewModel<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
}
