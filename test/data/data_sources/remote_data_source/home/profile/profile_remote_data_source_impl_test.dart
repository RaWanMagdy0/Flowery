import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/core/local/token_manger.dart';
import 'package:flowery/data/api/home_api/home_api_manager.dart';
import 'package:flowery/data/data_sources/remote_data_source/home/profile/profile_remote_data_source_impl.dart';
import 'package:flowery/data/models/home/profile/AppUserModel.dart';
import 'package:flowery/domain/entities/home_layout/profile/User.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../home/home_remote_data_source_test.mocks.dart';

@GenerateMocks([HomeApiManger])
void main() {
  late MockHomeApiManger mockApiManger;
  late ProfileRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiManger = MockHomeApiManger();
    dataSource = ProfileRemoteDataSourceImpl(apiManger: mockApiManger);
  });
  group('getLoggedUserInfo', () {
    test('should return User when token is valid and API call is successful', () async {
      // Arrange
      const token = "mockedToken";
      final mockUser = User();
      final mockAppUserModel = AppUserModel();
      when(mockAppUserModel.toUser()).thenReturn(mockUser);
      when(TokenManager.getToken()).thenAnswer((_) async => token);
      when(mockApiManger.getLoggedUserInfo('Bearer $token'))
          .thenAnswer((_) async => mockAppUserModel);

      // Act
      final result = await dataSource.getLoggedUserInfo();

      expect(result, isA<Success<User?>>());
      expect((result as Success<User?>).data,mockUser);
    });

    test('should throw Exception when token is missing', () async {
      // Arrange
      when(TokenManager.getToken()).thenAnswer((_) async => null);

      // Act
      final call = dataSource.getLoggedUserInfo;

      // Assert
      expect(() => call(), throwsA(isA<Exception>()));
    });
  });
}
