import '../../../domain/entities/home/home_category_entity.dart';

class HomeCategoryModel {
  final String? id;
  final String? name;
  final String? slug;
  final String? imageUrl;
  final String? createdAt;
  final String? updatedAt;

  HomeCategoryModel({
    this.id,
    this.name,
    this.slug,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  HomeCategory toEntity() => HomeCategory(
        id: id,
        name: name,
        slug: slug,
        imageUrl: imageUrl,
      );

  factory HomeCategoryModel.fromJson(Map<String, dynamic> json) {
    return HomeCategoryModel(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      imageUrl: json['image'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['image'] = imageUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
