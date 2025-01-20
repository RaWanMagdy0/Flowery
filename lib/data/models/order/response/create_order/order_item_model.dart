
import 'package:flowery/domain/entities/order/create_order/order_item.dart';
import 'product_model.dart';

class OrderItemModel {
  OrderItemModel({
      this.product,
      this.price,
      this.quantity,
      this.id,});

  OrderItemModel.fromJson(dynamic json) {
    product = json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    price = json['price'];
    quantity = json['quantity'];
    id = json['_id'];
  }
  ProductModel? product;
  int? price;
  int? quantity;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (product != null) {
      map['product'] = product?.toJson();
    }
    map['price'] = price;
    map['quantity'] = quantity;
    map['_id'] = id;
    return map;
  }
  OrderItem toEntity() {
    return OrderItem(
      id: id ?? "",
      price: price ?? 0,
      quantity: quantity ?? 0,
      product: product?.toEntity(),
    );
  }
}