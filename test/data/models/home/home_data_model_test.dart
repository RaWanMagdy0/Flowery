import 'dart:convert';

import 'package:flowery/data/models/home/home_discovery_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  test(
    'should return HomeDataModel from json',
    () {
      // arrange
      final Map<String, dynamic> jsonData = jsonDecode(
        fixtureReader(
          folderName: 'home',
          fileName: 'home_data.json',
        ),
      );

      // act
      final result = HomeDiscoveryModel.fromJson(jsonData);

      // assert
      expect(result, isA<HomeDiscoveryModel>());
    },
  );
}
