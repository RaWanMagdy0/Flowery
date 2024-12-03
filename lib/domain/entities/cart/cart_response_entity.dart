import 'cart_entity.dart';

class CartResponse {
  final num? numberOfItems;
  final Cart? cart;

  const CartResponse({
    this.numberOfItems,
    this.cart,
  });
}
