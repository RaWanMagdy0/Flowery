import 'package:flutter/cupertino.dart';

import '../../../../data/model/auth/response/produc_details_model.dart';

@immutable
sealed class ProductDetailsStates {}

class ProductDetailsInitialState extends ProductDetailsStates {}

class ProductDetailsErrorState extends ProductDetailsStates {
  final String? errorMessage;
  ProductDetailsErrorState({required this.errorMessage});
}

class ProductDetailsSuccessState extends ProductDetailsStates {
  final ProductDetailsModel? success;
  ProductDetailsSuccessState({required this.success});
}

class ProductDetailsLoadingState extends ProductDetailsStates {
  final String? loadingMessage;
  ProductDetailsLoadingState({required this.loadingMessage});
}
