import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/model/home/produc_details_model.dart';
import 'package:flowery/domain/repository/home/home_repository.dart';
import 'package:flowery/domain/use_case/home/product_details_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_home_data_use_case_test.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  late MockHomeRepository mockHomeRepository;
  late ProductDetailsUseCase usecase;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = ProductDetailsUseCase(repository: mockHomeRepository);
  });
  setUpAll(() {
    provideDummy<Result<ProductDetailsModel?>>(
        Success<ProductDetailsModel?>(data: null));
  });

  group('productDetailsUseCase ', () {
    final testData = ProductDetailsModel();
    const testId = "123";
    final testException = Exception('Test failure');

    test('should get productDetails', () async {
      // arrange
      when(mockHomeRepository.getProductDetails(productId: testId))
          .thenAnswer((_) async => Success(data: testData));
      final result = await usecase.invoke(productId: testId);
      expect(result, isA<Success<ProductDetailsModel?>>());
      expect((result as Success<ProductDetailsModel?>).data, testData);
    });

    test('should return Fail when productDetails returns failure', () async {
      when(mockHomeRepository.getProductDetails(productId: testId))
          .thenAnswer((_) async => Fail(exception: testException));
      final result = await usecase.invoke(productId: testId);

      expect(result, isA<Fail<ProductDetailsModel?>>());
      expect((result as Fail<ProductDetailsModel?>).exception, testException);
    });
  });
}
