import 'package:flutter/cupertino.dart';

import '../../../../domain/entities/home_layout/product_details_entity.dart';

@immutable
sealed class ProductDetailsStates {}

class ProductDetailsInitialState extends ProductDetailsStates {}

class ProductDetailsErrorState extends ProductDetailsStates {
  final String? errorMessage;
  ProductDetailsErrorState({required this.errorMessage});
}

class ProductDetailsSuccessState extends ProductDetailsStates {
  final ProductDetailsEntity? success;
  ProductDetailsSuccessState({required this.success});
}

class ProductDetailsLoadingState extends ProductDetailsStates {
  final String? loadingMessage;
  ProductDetailsLoadingState({required this.loadingMessage});
}
