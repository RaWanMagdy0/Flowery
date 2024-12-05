class OrderItems {
  OrderItems({
      this.product, 
      this.price, 
      this.quantity, 
      this.id,});

  OrderItems.fromJson(dynamic json) {
    product = json['product'];
    price = json['price'];
    quantity = json['quantity'];
    id = json['_id'];
  }
  String? product;
  int? price;
  int? quantity;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product'] = product;
    map['price'] = price;
    map['quantity'] = quantity;
    map['_id'] = id;
    return map;
  }

}