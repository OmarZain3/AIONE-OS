import 'package:founder_studio/domain/auth/auth_tokens.dart';
import 'package:founder_studio/domain/auth/auth_user.dart';

/// Contract for authentication operations.
abstract class AuthRepository {
  Future<AuthUser> login({required String email, required String password});

  Future<AuthUser?> getCurrentUser();

  Future<AuthTokens?> readStoredTokens();

  Future<AuthUser?> restoreSession();

  Future<AuthTokens> refreshTokens();

  Future<void> logout();

  String? get accessToken;
}
