import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/data_source/remote_data_source/home/home_remote_data_source.dart';
import 'package:flowery/data/models/home/home_data_model.dart';
import 'package:flowery/data/repository/home/home_repository_impl.dart';
import 'package:flowery/domain/entities/home/home_data_entity.dart';
import 'package:flowery/domain/repository/home/home_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repository_test.mocks.dart';

@GenerateMocks([HomeRemoteDataSource, HomeData, HomeDataModel])
void main() {
  late MockHomeRemoteDataSource mockHomeRemoteDataSource;
  late HomeRepository repository;

  setUp(() {
    mockHomeRemoteDataSource = MockHomeRemoteDataSource();
    repository = HomeRepositoryImpl(onlineDataSource: mockHomeRemoteDataSource);
  });

  group('getHomeData', () {
    test('should get home data from online data source', () async {
      // arrange
      final data = HomeDataModel();
      var mockedRemoteResult = Success<HomeDataModel>(data: data);
      provideDummy<Result<HomeDataModel>>(mockedRemoteResult);

      when(mockHomeRemoteDataSource.getHomeData())
          .thenAnswer((_) async => mockedRemoteResult);

      // act
      final result = await repository.getHomeData();

      // Assert
      expect(result, isA<Success<HomeData?>>());
    });

    test('should return Fail when HomeRemoteDataSource returns failure',
        () async {
      // arrange
      final exception = Exception("Network error");
      final mockedRemoteResult = Fail<HomeDataModel>(exception: exception);
      provideDummy<Result<HomeDataModel>>(mockedRemoteResult);

      when(mockHomeRemoteDataSource.getHomeData())
          .thenAnswer((_) async => mockedRemoteResult);

      // act
      final result = await repository.getHomeData();

      // assert
      expect(result, isA<Fail<HomeData?>>());
    });
  });
}
