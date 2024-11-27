import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/api/home_api/home_api_manager.dart';
import 'package:flowery/data/data_sources/remote_data_source/home/home/home_remote_data_source.dart';
import 'package:flowery/data/data_sources/remote_data_source/home/home/home_remote_data_source_impl.dart';
import 'package:flowery/data/models/home/home/home_data_model.dart';
import 'package:flowery/data/models/produc_details_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_remote_data_source_test.mocks.dart';

@GenerateMocks([HomeApiManger])
void main() {
  late MockHomeApiManger mockHomeApiManger;
  late HomeRemoteDataSource dataSource;

  setUp(() {
    mockHomeApiManger = MockHomeApiManger();
    dataSource = HomeRemoteDataSourceImpl(mockHomeApiManger);
  });

  group('HomeRemoteDataSource --> getHomeData func', () {
    test('should return HomeDataModel', () async {
      // arrange
      final data = HomeDataModel();
      final mockedApiResult = Future<HomeDataModel>(() => data);
      provideDummy<Future<HomeDataModel>>(mockedApiResult);

      when(mockHomeApiManger.getHomeData())
          .thenAnswer((_) async => Future.value(mockedApiResult));

      // act
      final result = await dataSource.getHomeData();

      // assert
      expect(result, isA<Success<HomeDataModel>>());
    });

    test('should return Fail when HomeApiManager throws exception', () async {
      // arrange
      final exception = Exception("Network error");
      final mockedApiResult = Future<HomeDataModel>(() => throw exception);
      provideDummy<Future<HomeDataModel>>(mockedApiResult);

      when(mockHomeApiManger.getHomeData())
          .thenAnswer((_) async => mockedApiResult);

      // act
      final result = await dataSource.getHomeData();

      // assert
      expect(result, isA<Fail<HomeDataModel?>>());
    });
  });

  group('HomeRemoteDataSource --> getProductDetails', () {
    final testData = ProductDetailsModel();
    final testId = "1234";
    const testFailMessage = "Failed to getProductDetails.";
    test('should return productDetails  when getProductDetails is successful',
        () async {
      // arrange
      when(mockHomeApiManger.getProductDetails(testId))
          .thenAnswer((_) async => testData);
      // act
      final result = await dataSource.getProductDetails(productId: testId);
      // assert
      expect(result, isA<Success<ProductDetailsModel?>>());
      expect((result as Success<ProductDetailsModel?>).data, testData);
    });

    test('should return fail message when getProductDetails is Failure',
        () async {
      // arrange
      when(mockHomeApiManger.getProductDetails(testId))
          .thenThrow(Exception(testFailMessage));
      // act
      final result = await dataSource.getProductDetails(productId: testId);
      // assert
      expect(result, isA<Fail<ProductDetailsModel?>>());
      expect((result as Fail<ProductDetailsModel?>).exception.toString(),
          contains(testFailMessage));
    });
  });
}
