import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/data_sources/remote_data_source/home/home/home_remote_data_source.dart';
import 'package:flowery/data/models/produc_details_model.dart';
import 'package:flowery/data/repository/home/home_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../domain/repository/home/home_repository_test.mocks.dart';

@GenerateMocks([HomeRemoteDataSource])
void main() {
  late HomeRepositoryImpl repository;
  late MockHomeRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSource();
    repository = HomeRepositoryImpl(onlineDataSource: mockRemoteDataSource);
  });
  setUpAll(() {
    provideDummy<Result<ProductDetailsModel?>>(
        Success<ProductDetailsModel?>(data: null));
  });

  group('getProductDetails', () {
    const testProductId = '1234';
    final testException = Exception('Test failure');
    final testData = ProductDetailsModel();

    test('should return Success when remote data source returns Success',
        () async {
      when(mockRemoteDataSource.getProductDetails(productId: testProductId))
          .thenAnswer((_) async => Success(data: testData));
      final result =
          await repository.getProductDetails(productId: testProductId);
      expect(result, isA<Success<ProductDetailsModel?>>());
      expect((result as Success<ProductDetailsModel?>).data, testData);
    });

    test('should return Fail when remote data source returns Fail', () async {
      when(mockRemoteDataSource.getProductDetails(productId: testProductId))
          .thenAnswer((_) async => Fail(exception: testException));
      final result =
          await repository.getProductDetails(productId: testProductId);
      expect(result, isA<Fail<ProductDetailsModel?>>());
      expect((result as Fail<ProductDetailsModel?>).exception, testException);
    });
  });
}
