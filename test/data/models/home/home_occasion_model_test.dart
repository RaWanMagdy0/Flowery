import 'dart:convert';

import 'package:flowery/data/models/home/home_occasion_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  test(
    'should return HomeOccasionModel from json',
    () {
      // arrange
      final Map<String, dynamic> jsonData = jsonDecode(
        fixtureReader(
          folderName: 'home',
          fileName: 'home_occasion.json',
        ),
      );

      // act
      final result = HomeOccasionModel.fromJson(jsonData);

      // assert
      expect(result, isA<HomeOccasionModel>());
    },
  );
}
