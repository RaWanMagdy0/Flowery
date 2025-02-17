class ProductEntityDriver {
  ProductEntityDriver({
      this.id, 
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
      this.sold,});

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
  int? discount;
  int? sold;


}