class ProductDetailsEntity {
  ProductDetailsEntity({
      this.message, 
      this.products,});

  String? message;
  List<ProductEntity>? products;

}

class ProductEntity {
  ProductEntity({
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
      this.id,});

  String? id;
  String? title;
  String? slug;
  String? description;
  String? imgCover;
  List<String>? images;
  int? price;
  int? priceAfterDiscount;
  int? quantity;
  String? category;
  String? occasion;
  String? createdAt;
  String? updatedAt;
  int? v;


}