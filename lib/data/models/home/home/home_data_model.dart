import '../../../../domain/entities/home/home_data_entity.dart';
import 'home_best_seller_product_model.dart';
import 'home_category_model.dart';
import 'home_discovery_model.dart';
import 'home_occasion_model.dart';

class HomeDataModel {
  final String? message;
  final List<HomeDiscoveryModel>? discovery;
  final List<HomeCategoryModel>? categories;
  final List<HomeBestSellerProductModel>? bestSellerProducts;
  final List<HomeOccasionModel>? occasions;

  HomeDataModel({
    this.message,
    this.discovery,
    this.categories,
    this.bestSellerProducts,
    this.occasions,
  });

  HomeData toEntity() => HomeData(
        discovery: discovery?.map((e) => e.toEntity()).toList(),
        categories: categories?.map((e) => e.toEntity()).toList(),
        bestSellerProducts:
            bestSellerProducts?.map((e) => e.toEntity()).toList(),
        occasions: occasions?.map((e) => e.toEntity()).toList(),
      );

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel(
      message: json['message'],
      discovery: (json['discovery'] as List<dynamic>?)
          ?.map((e) => HomeDiscoveryModel.fromJson(e))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => HomeCategoryModel.fromJson(e))
          .toList(),
      bestSellerProducts: (json['bestSeller'] as List<dynamic>?)
          ?.map((e) => HomeBestSellerProductModel.fromJson(e))
          .toList(),
      occasions: (json['occasions'] as List<dynamic>?)
          ?.map((e) => HomeOccasionModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'discovery': discovery?.map((x) => x.toJson()).toList(),
      'categories': categories?.map((x) => x.toJson()).toList(),
      'bestSellerProducts': bestSellerProducts?.map((x) => x.toJson()).toList(),
      'occasions': occasions?.map((x) => x.toJson()).toList(),
    };
  }
}
