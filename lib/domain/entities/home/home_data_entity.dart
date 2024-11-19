import 'home_best_seller_product_entity.dart';
import 'home_category_entity.dart';
import 'home_discovery_entity.dart';
import 'home_occasion_entity.dart';

class HomeData {
  final List<HomeDiscovery>? discovery;
  final List<HomeCategory>? categories;
  final List<HomeBestSellerProduct>? bestSellerProducts;
  final List<HomeOccasion>? occasions;

  HomeData({
    this.discovery,
    this.categories,
    this.bestSellerProducts,
    this.occasions,
  });

  HomeData copyWith({
    List<HomeDiscovery>? discovery,
    List<HomeCategory>? categories,
    List<HomeBestSellerProduct>? bestSellerProducts,
    List<HomeOccasion>? occasions,
  }) {
    return HomeData(
      discovery: discovery ?? this.discovery,
      categories: categories ?? this.categories,
      bestSellerProducts: bestSellerProducts ?? this.bestSellerProducts,
      occasions: occasions ?? this.occasions,
    );
  }
}
