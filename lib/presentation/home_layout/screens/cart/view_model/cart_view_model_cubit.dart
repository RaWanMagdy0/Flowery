import 'package:injectable/injectable.dart';

import '../../../../../core/base/base_view_model.dart';

part 'cart_state.dart';

@injectable
class CartViewModel extends BaseViewModel<CartState> {
  CartViewModel() : super(CartInitial());

  int cartItemsCount = 4;
}
