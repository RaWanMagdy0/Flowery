import '../../../domain/entities/cart/cart_product_entity.dart';
import '../produc_details_model.dart';

class CartProductModel {
  final String? id;
  final num? price;
  final int? quantity;
  final ProductModel? product;

  CartProductModel({
    this.id,
    this.price,
    this.quantity,
    this.product,
  });

  CartProduct toEntity() {
    return CartProduct(
      id: id,
      price: price,
      quantity: quantity,
      product: product?.toEntity(),
    );
  }

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
      id: json['_id'],
      price: json['price'],
      quantity: json['quantity'],
      product: ProductModel.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'price': price,
      'quantity': quantity,
      'product': product?.toJson(),
    };
  }
}
