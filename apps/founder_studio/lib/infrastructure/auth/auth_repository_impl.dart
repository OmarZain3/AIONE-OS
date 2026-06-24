import 'package:founder_studio/domain/auth/auth_repository.dart';
import 'package:founder_studio/domain/auth/auth_tokens.dart';
import 'package:founder_studio/domain/auth/auth_user.dart';
import 'package:founder_studio/infrastructure/auth/auth_api_client.dart';
import 'package:founder_studio/infrastructure/auth/secure_token_storage.dart';

/// Infrastructure implementation of [AuthRepository].
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    AuthApiClient? apiClient,
    SecureTokenStorage? tokenStorage,
  }) : _apiClient = apiClient ?? AuthApiClient(),
       _tokenStorage = tokenStorage ?? SecureTokenStorage();

  final AuthApiClient _apiClient;
  final SecureTokenStorage _tokenStorage;

  AuthTokens? _cachedTokens;

  @override
  String? get accessToken => _cachedTokens?.accessToken;

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    final tokens = await _apiClient.login(email: email, password: password);
    await _persistTokens(tokens);
    return _apiClient.currentUser(accessToken: tokens.accessToken);
  }

  @override
  Future<AuthUser?> getCurrentUser() async {
    final token = accessToken;
    if (token == null) {
      return null;
    }
    return _apiClient.currentUser(accessToken: token);
  }

  @override
  Future<AuthTokens?> readStoredTokens() async {
    if (_cachedTokens != null) {
      return _cachedTokens;
    }
    final stored = await _tokenStorage.readTokens();
    if (stored.access == null || stored.refresh == null) {
      return null;
    }
    _cachedTokens = AuthTokens(
      accessToken: stored.access!,
      refreshToken: stored.refresh!,
    );
    return _cachedTokens;
  }

  @override
  Future<AuthUser?> restoreSession() async {
    final tokens = await readStoredTokens();
    if (tokens == null) {
      return null;
    }

    try {
      await _apiClient.verify(token: tokens.accessToken);
      return _apiClient.currentUser(accessToken: tokens.accessToken);
    } on AuthApiException {
      try {
        final refreshed = await refreshTokens();
        return _apiClient.currentUser(accessToken: refreshed.accessToken);
      } on AuthApiException {
        await _tokenStorage.clear();
        _cachedTokens = null;
        return null;
      }
    }
  }

  @override
  Future<AuthTokens> refreshTokens() async {
    final tokens = await readStoredTokens();
    if (tokens == null) {
      throw const AuthApiException('No refresh token available');
    }
    final refreshed = await _apiClient.refresh(
      refreshToken: tokens.refreshToken,
    );
    final updated = AuthTokens(
      accessToken: refreshed.accessToken,
      refreshToken: tokens.refreshToken,
    );
    await _persistTokens(updated);
    return updated;
  }

  @override
  Future<void> logout() async {
    final tokens = await readStoredTokens();
    if (tokens != null) {
      try {
        await _apiClient.logout(
          accessToken: tokens.accessToken,
          refreshToken: tokens.refreshToken,
        );
      } on AuthApiException {
        // Session may already be invalid — still clear local state.
      }
    }
    await _tokenStorage.clear();
    _cachedTokens = null;
  }

  Future<void> _persistTokens(AuthTokens tokens) async {
    _cachedTokens = tokens;
    await _tokenStorage.saveTokens(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
  }
}
