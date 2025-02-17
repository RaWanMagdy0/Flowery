
import 'product.dart';

class OrderItemDriver {
  OrderItemDriver({
      this.product, 
      this.price, 
      this.quantity, 
      this.id,});

  ProductEntityDriver? product;
  int? price;
  int? quantity;
  String? id;


}