import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/entities/home/home_data_entity.dart';
import 'package:flowery/domain/repository/home/home_repository.dart';
import 'package:flowery/domain/use_case/home/get_home_data_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_home_data_use_case_test.mocks.dart';

@GenerateMocks([HomeRepository, HomeData])
void main() {
  late MockHomeRepository mockHomeRepository;
  late GetHomeDataUseCase usecase;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = GetHomeDataUseCase(mockHomeRepository);
  });

  group('getHomeDataUseCase --> invoke func', () {
    test('should get home data from repository', () async {
      // arrange
      final data = HomeData();
      var mockedResult = Success<HomeData?>(data: data);
      provideDummy<Result<HomeData?>>(mockedResult);

      when(mockHomeRepository.getHomeData())
          .thenAnswer((_) async => mockedResult);

      // act
      final result = await usecase.invoke();

      // assert
      expect(result, isA<Success<HomeData?>>());
    });

    test('should return Fail when HomeRepository returns failure', () async {
      // arrange
      final exception = Exception("Network error");
      final mockedResult = Fail<HomeData?>(exception: exception);
      provideDummy<Result<HomeData?>>(mockedResult);

      when(mockHomeRepository.getHomeData())
          .thenAnswer((_) async => mockedResult);

      // act
      final result = await usecase.invoke();

      // assert
      expect(result, isA<Fail<HomeData?>>());
    });
  });
}
