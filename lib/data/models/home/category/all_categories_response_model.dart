import '../home/home_category_model.dart';

class AllCategoriesResponseModel {
  final String? message;

  final List<HomeCategoryModel>? categories;

  AllCategoriesResponseModel({
    this.message,
    this.categories,
  });

  factory AllCategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    return AllCategoriesResponseModel(
      message: json['message'],
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => HomeCategoryModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'categories': categories?.map((x) => x.toJson()).toList(),
    };
  }
}
