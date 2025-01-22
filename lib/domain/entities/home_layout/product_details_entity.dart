class ProductDetailsEntity {
  ProductDetailsEntity({
    this.message,
    this.products,
  });

  String? message;
  List<ProductEntity>? products;
}

class ProductEntity {
  ProductEntity({
    this.id,
    this.discount,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    required this.price,
    required this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? title;
  String? slug;
  String? description;
  String? imgCover;
  List<String>? images;
  final int price;
  final int priceAfterDiscount;
  int? quantity;
  String? category;
  String? occasion;
  String? createdAt;
  String? updatedAt;
  int? v;
  int? discount;
}
