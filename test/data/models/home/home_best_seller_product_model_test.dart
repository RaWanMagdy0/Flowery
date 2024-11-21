import 'dart:convert';

import 'package:flowery/data/models/home/home_best_seller_product_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  test(
    'should return HomeBestSellerProductModel from json',
    () {
      // arrange
      final Map<String, dynamic> jsonData = jsonDecode(
        fixtureReader(
          folderName: 'home',
          fileName: 'home_best_seller_product.json',
        ),
      );

      // act
      final result = HomeBestSellerProductModel.fromJson(jsonData);

      // assert
      expect(result, isA<HomeBestSellerProductModel>());
    },
  );
}
