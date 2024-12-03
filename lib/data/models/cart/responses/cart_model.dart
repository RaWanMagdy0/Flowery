import '../../../../domain/entities/cart/cart_entity.dart';
import 'cart_product_model.dart';

class CartModel {
  final String? id;
  final String? userId;
  final num? totalPrice;
  final List<CartProductModel>? products;
  final String? createdAt;
  final String? updatedAt;
  final num? v;

  CartModel({
    this.id,
    this.userId,
    this.totalPrice,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Cart toEntity() {
    return Cart(
      id: id,
      userId: userId,
      totalPrice: totalPrice,
      products: products?.map((e) => e.toEntity()).toList(),
    );
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'],
      userId: json['user'],
      totalPrice: json['totalPrice'],
      products: (json['cartItems'] as List)
          .map((e) => CartProductModel.fromJson(e))
          .toList(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': userId,
      'totalPrice': totalPrice,
      'cartItems': products?.map((e) => e.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}
