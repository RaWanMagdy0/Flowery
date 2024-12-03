import '../home_layout/product_details_entity.dart';

class CartProduct {
  final String? id;
  final num? price;
  final num? quantity;
  final num? totalPrice;
  final ProductEntity? product;

  CartProduct({
    this.id,
    this.price,
    this.quantity,
    this.product,
  }) : totalPrice = (price ?? 0) * (quantity ?? 0);
}
