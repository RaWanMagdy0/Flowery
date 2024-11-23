import 'secure_storage.dart';

class TokenManger {
  static const String tokenKey = "token";

  static Future<void> setToken({required String token}) async {
    return await SecureStorageFunction.writeData(key: tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await SecureStorageFunction.readData(key: tokenKey);
  }

  static Future<void> deleteToken() async {
    return await SecureStorageFunction.deleteData(key: tokenKey);
  }
}
