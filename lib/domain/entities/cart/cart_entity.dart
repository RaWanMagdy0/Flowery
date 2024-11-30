import 'cart_product_entity.dart';

class Cart {
  final String? id;
  final String? userId;
  final num? totalPrice;
  final List<CartProduct>? products;

  Cart({
    this.id,
    this.userId,
    this.totalPrice,
    this.products,
  });
}
