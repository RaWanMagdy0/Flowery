import '../../../domain/entities/home/home_best_seller_product_entity.dart';

class HomeBestSellerProductModel {
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imagesCoverUrl;
  final List<String>? imagesUrl;
  final int? price;
  final int? priceAfterDiscount;
  final int? quantity;
  final String? category;
  final String? occasion;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  HomeBestSellerProductModel({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imagesCoverUrl,
    this.imagesUrl,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  HomeBestSellerProduct toEntity() => HomeBestSellerProduct(
        id: id,
        title: title,
        slug: slug,
        imageUrl: imagesCoverUrl,
        price: price,
        priceAfterDiscount: priceAfterDiscount,
      );

  factory HomeBestSellerProductModel.fromJson(Map<String, dynamic> json) {
    return HomeBestSellerProductModel(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      imagesCoverUrl: json['imgCover'],
      imagesUrl: List<String>.from(json['images']),
      price: json['price'],
      priceAfterDiscount: json['priceAfterDiscount'],
      quantity: json['quantity'],
      category: json['category'],
      occasion: json['occasion'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['description'] = description;
    data['imgCover'] = imagesCoverUrl;
    data['images'] = imagesUrl;
    data['price'] = price;
    data['priceAfterDiscount'] = priceAfterDiscount;
    data['quantity'] = quantity;
    data['category'] = category;
    data['occasion'] = occasion;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = v;
    return data;
  }
}
