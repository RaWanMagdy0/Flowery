


import '../../../domain/entities/pending_orders/order_item.dart';
import 'product_model.dart';

class OrderItemModelDriver {
  OrderItemModelDriver({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  OrderItemModelDriver.fromJson(dynamic json) {
    product =
        json['product'] != null ? ProductModelDriver.fromJson(json['product']) : null;
    price = json['price'];
    quantity = json['quantity'];
    id = json['_id'];
  }
  ProductModelDriver? product;
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
  OrderItemDriver? toEntity() {
   return OrderItemDriver(
        price: price,
        quantity: quantity,
        id: id,
     product: product!.toEntity()
   );
  }
}
