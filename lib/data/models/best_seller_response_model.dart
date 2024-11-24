import 'best_seller_model.dart';

class BestSellerResponseModel {
  final String? message;
  final List<BestSellerModel>? bestSellers;

  BestSellerResponseModel({
    this.message,
    this.bestSellers,
  });

  factory BestSellerResponseModel.fromJson(Map<String, dynamic> json) {
    return BestSellerResponseModel(
      message: json['message'],
      bestSellers: (json['bestSeller'] as List<dynamic>?)
          ?.map((e) => BestSellerModel.fromJson(e))
          .toList(),
    );
  }
}
