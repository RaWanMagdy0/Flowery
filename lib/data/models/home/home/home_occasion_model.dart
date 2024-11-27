import '../../../../domain/entities/home/home_occasion_entity.dart';

class HomeOccasionModel {
  final String? id;
  final String? name;
  final String? slug;
  final String? imageUrl;
  final String? createdAt;
  final String? updatedAt;

  HomeOccasionModel({
    this.id,
    this.name,
    this.imageUrl,
    this.slug,
    this.createdAt,
    this.updatedAt,
  });

  HomeOccasion toEntity() => HomeOccasion(
        id: id,
        name: name,
        imageUrl: imageUrl,
        slug: slug,
      );

  factory HomeOccasionModel.fromJson(Map<String, dynamic> json) {
    return HomeOccasionModel(
      id: json['_id'],
      name: json['name'],
      imageUrl: json['image'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': imageUrl,
      'slug': slug,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
