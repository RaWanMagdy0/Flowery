import 'cart_product_model.dart';

class CartProductsResponseModel {
  final String? message;
  final List<CartProductModel>? cart;

  const CartProductsResponseModel({this.message, this.cart});

  factory CartProductsResponseModel.fromJson(Map<String, dynamic> json) {
    return CartProductsResponseModel(
      message: json['message'],
      cart: json['cart'] != null
          ? List<CartProductModel>.from(
              json['cart'].map((x) => CartProductModel.fromJson(x)))
          : [],
    );
  }
}
