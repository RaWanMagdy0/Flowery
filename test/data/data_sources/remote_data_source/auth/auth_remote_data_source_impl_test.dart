import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/api/auth_api/auth_api_manager.dart';
import 'package:flowery/data/data_sources/remote_data_source/auth/auth_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AuthApiManager])
void main() {
  late MockAuthApiManager mockApiManger;
  late AuthRemoteDataSourceImpl authRemoteDataSource;

  setUp(() {
    mockApiManger = MockAuthApiManager();
    authRemoteDataSource = AuthRemoteDataSourceImpl(apiManger: mockApiManger);
  });
  //forgotPassword
  group("forgotPassword", () {
    const testEmail = "Rawan@123";
    const testSuccessMessage = "Password reset email sent.";
    const testFailMessage = "Failed to reset password.";
    test("should return success message when forgetPassword is successful",
        () async {
      when(mockApiManger.forgetPassword({"email": testEmail}))
          .thenAnswer((_) async => testSuccessMessage);
      final result =
          await authRemoteDataSource.forgotPassword(email: testEmail);
      expect(result, isA<Success<String?>>());
      expect((result as Success<String?>).data, testSuccessMessage);
    });
    test("should return fail message when forgotPassword is Failure", () async {
      when(mockApiManger.forgetPassword({"email": testEmail}))
          .thenThrow(Exception(testFailMessage));
      final result =
          await authRemoteDataSource.forgotPassword(email: testEmail);
      expect(result, isA<Fail<String?>>());
      expect((result as Fail<String?>).exception.toString(),
          contains(testFailMessage));
    });
  });

  //resetPassword
  group("resetPassword", () {
    const testCode = "Rawan@123";
    const testSuccessMessage = "sent ResetCode Successful.";
    const testFailMessage = "Failed to sent ResetCode.";
    test("should return success message when ResetCode is successful",
        () async {
      when(mockApiManger.verifyResetCode({"resetCode": testCode}))
          .thenAnswer((_) async => testSuccessMessage);
      final result =
          await authRemoteDataSource.verifyResetCode(resetCode: testCode);
      expect(result, isA<Success<String?>>());
      expect((result as Success<String?>).data, testSuccessMessage);
    });
    test("should return fail message when forgotPassword is Failure", () async {
      when(mockApiManger.verifyResetCode({"resetCode": testCode}))
          .thenThrow(Exception(testFailMessage));
      final result =
          await authRemoteDataSource.verifyResetCode(resetCode: testCode);
      expect(result, isA<Fail<String?>>());
      expect((result as Fail<String?>).exception.toString(),
          contains(testFailMessage));
    });
  });
}
