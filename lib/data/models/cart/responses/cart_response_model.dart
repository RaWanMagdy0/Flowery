import '../../../../domain/entities/cart/cart_response_entity.dart';
import 'cart_model.dart';

class CartResponseModel {
  final String? message;
  final num? numberOfItems;
  final CartModel? cart;

  const CartResponseModel({
    this.message,
    this.numberOfItems,
    this.cart,
  });

  CartResponse toEntity() {
    return CartResponse(
      numberOfItems: numberOfItems,
      cart: cart?.toEntity(),
    );
  }

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      message: json['message'],
      numberOfItems: json['numOfCartItems'],
      cart: CartModel.fromJson(json['cart']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'numOfCartItems': numberOfItems,
      'cart': cart?.toJson(),
    };
  }
}
