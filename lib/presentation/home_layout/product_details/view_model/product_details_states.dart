import 'package:flowery/data/model/auth/response/ProductDetailsModel.dart';
import 'package:flutter/cupertino.dart';

@immutable
sealed class ProductDetailsStates {}

class ProductDetailsInitialState extends ProductDetailsStates {}

class ProductDetailsErrorState extends ProductDetailsStates {
  String? errorMessage;
  ProductDetailsErrorState({required this.errorMessage});
}

class ProductDetailsSuccessState extends ProductDetailsStates {
  final ProductDetailsModel? success;
  ProductDetailsSuccessState({required this.success});
}

class ProductDetailsLoadingState extends ProductDetailsStates {
  String? loadingMessage;
  ProductDetailsLoadingState({required this.loadingMessage});
}
