import '../../../../domain/entities/cart/cart_product_entity.dart';
import '../../produc_details_model.dart';

class CartProductModel {
  final String? id;
  final ProductModel? product;
  final num? price;
  final num? quantity;

  CartProductModel({
    this.id,
    this.price,
    this.quantity,
    this.product,
  });

  CartProduct toEntity() {
    return CartProduct(
      id: id,
      product: product?.toEntity(),
      price: price,
      quantity: quantity,
    );
  }

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
      id: json['_id'],
      product: ProductModel.fromJson(json['product']),
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'product': product?.toJson(),
      'price': price,
      'quantity': quantity,
    };
  }
}
