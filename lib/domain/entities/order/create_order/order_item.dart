import 'Product.dart';

class OrderItem {
  OrderItem({
      this.product, 
      this.price, 
      this.quantity, 
      this.id,});

  Product? product;
  int? price;
  int? quantity;
  String? id;


}