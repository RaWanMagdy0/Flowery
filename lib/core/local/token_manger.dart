import 'package:encrypt/encrypt.dart';

import 'caching_prefs_factory.dart';

class TokenManger {
  static const String tokenKey = "token";

  static Future<void> setToken({required String token}) async {
    final key = Key.fromUtf8(
        '32charactertestkey1234567890'); // يجب أن يكون طول المفتاح 32 حرف
    final iv = IV.fromLength(16); // طول IV هو 16 بايت

    final encrypter = Encrypter(AES(key));

    // تشفير النص
    final encrypted = encrypter.encrypt(token, iv: iv);
    // Use a logging framework instead of print
    print('Encrypted: ${encrypted.base64}');

    return await CachingPrefsFactory.writeString(
        key: tokenKey.toString(), value: encrypted.base64);
  }

  static Future<String?> getToken() async {
    final key = Key.fromUtf8(
        '32charactertestkey1234567890'); // يجب أن يكون طول المفتاح 32 حرف
    final iv = IV.fromLength(16); // طول IV هو 16 بايت

    final encrypter = Encrypter(AES(key));

    final String encryptedToken =
        await CachingPrefsFactory.readString(tokenKey) ?? '';
    final encrypted = Encrypted.fromBase64(encryptedToken);

    // فك تشفير النص
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    // Use a logging framework instead of print
    print('Decrypted: $decrypted');
    return decrypted;
  }

  static Future<void> deleteToken() async {
    await CachingPrefsFactory.deleteString(tokenKey);
  }
}
