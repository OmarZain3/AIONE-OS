import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:founder_studio/application/auth/auth_state.dart';
import 'package:founder_studio/domain/auth/auth_repository.dart';
import 'package:founder_studio/infrastructure/auth/auth_api_client.dart';
import 'package:founder_studio/infrastructure/auth/auth_repository_impl.dart';
import 'package:founder_studio/infrastructure/auth/authenticated_http_client.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});

final authenticatedHttpClientProvider = Provider<AuthenticatedHttpClient>((
  ref,
) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthenticatedHttpClient(authRepository: authRepository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._repository) : super(const AuthInitial());

  final AuthRepository _repository;

  static const _sessionRestoreTimeout = Duration(seconds: 3);

  Future<void> restoreSession() async {
    state = const AuthLoading();
    try {
      final user = await _repository.restoreSession().timeout(
        _sessionRestoreTimeout,
      );
      state = user != null
          ? AuthAuthenticated(user)
          : const AuthUnauthenticated();
    } on TimeoutException {
      state = const AuthUnauthenticated();
    } catch (error) {
      state = const AuthUnauthenticated();
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AuthLoading();
    try {
      final user = await _repository.login(email: email, password: password);
      state = AuthAuthenticated(user);
    } on AuthApiException catch (error) {
      state = AuthError(error.message);
    } catch (error) {
      state = AuthError(error.toString());
    }
  }

  Future<void> logout() async {
    state = const AuthLoading();
    await _repository.logout();
    state = const AuthUnauthenticated();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider) is AuthAuthenticated;
});
