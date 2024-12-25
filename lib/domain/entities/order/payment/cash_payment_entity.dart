// cash_payment_entity.dart

class CashPaymentEntity {
  CashPaymentEntity({
    this.message,
    this.order,
  });

  String? message;
  Order? order;
}

class Order {
  Order({
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? user;
  List<OrderItems>? orderItems;
  num? totalPrice;
  String? paymentType;
  bool? isPaid;
  bool? isDelivered;
  String? id;
  String? createdAt;
  String? updatedAt;
  num? v;
}

class OrderItems {
  OrderItems({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  Product? product;
  num? price;
  num? quantity;
  String? id;
}

class Product {
  Product({
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.discount,
    this.sold,
    this.id,
  });

  String? id;
  String? title;
  String? slug;
  String? description;
  String? imgCover;
  // Changed from List? to List<String>?
  List<String>? images;
  num? price;
  num? priceAfterDiscount;
  num? quantity;
  String? category;
  String? occasion;
  String? createdAt;
  String? updatedAt;
  num? v;
  num? discount;
  num? sold;
}
