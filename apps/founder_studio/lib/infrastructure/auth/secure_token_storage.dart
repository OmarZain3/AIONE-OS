import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persists JWT tokens using platform secure storage.
class SecureTokenStorage {
  SecureTokenStorage({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true),
            webOptions: WebOptions(
              dbName: 'founder_studio_secure',
              publicKey: 'founder_studio_public_key',
            ),
          );

  static const _accessKey = 'auth_access_token';
  static const _refreshKey = 'auth_refresh_token';

  final FlutterSecureStorage _storage;

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _accessKey, value: accessToken);
    await _storage.write(key: _refreshKey, value: refreshToken);
  }

  Future<({String? access, String? refresh})> readTokens() async {
    try {
      final access = await _storage.read(key: _accessKey);
      final refresh = await _storage.read(key: _refreshKey);
      return (access: access, refresh: refresh);
    } catch (_) {
      // Secure storage may be unavailable on web — treat as no session.
      return (access: null, refresh: null);
    }
  }

  Future<void> clear() => _storage.deleteAll();
}
