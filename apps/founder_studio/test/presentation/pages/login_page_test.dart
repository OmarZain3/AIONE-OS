import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:founder_studio/application/auth/auth_providers.dart';
import 'package:founder_studio/domain/auth/auth_repository.dart';
import 'package:founder_studio/domain/auth/auth_tokens.dart';
import 'package:founder_studio/domain/auth/auth_user.dart';
import 'package:founder_studio/l10n/app_localizations.dart';
import 'package:founder_studio/presentation/pages/login_page.dart';

class _FakeAuthRepository implements AuthRepository {
  bool shouldFail = false;

  @override
  String? get accessToken => null;

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    if (shouldFail) {
      throw Exception('Invalid credentials');
    }
    return const AuthUser(
      id: '1',
      email: 'founder@aione.test',
      firstName: 'Ada',
      lastName: 'Founder',
      fullName: 'Ada Founder',
      isActive: true,
    );
  }

  @override
  Future<AuthUser?> getCurrentUser() async => null;

  @override
  Future<AuthTokens?> readStoredTokens() async => null;

  @override
  Future<AuthUser?> restoreSession() async => null;

  @override
  Future<AuthTokens> refreshTokens() async {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {}
}

void main() {
  Widget wrap(Widget child, AuthRepository repository) {
    return ProviderScope(
      overrides: [authRepositoryProvider.overrideWithValue(repository)],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      ),
    );
  }

  testWidgets('LoginPage shows email and password fields', (tester) async {
    await tester.pumpWidget(wrap(const LoginPage(), _FakeAuthRepository()));
    await tester.pumpAndSettle();

    expect(find.text('Sign in'), findsWidgets);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets('LoginPage shows error message on failed sign in', (
    tester,
  ) async {
    final repository = _FakeAuthRepository()..shouldFail = true;
    await tester.pumpWidget(wrap(const LoginPage(), repository));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'founder@aione.test',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'wrong');
    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Invalid credentials'), findsOneWidget);
  });
}
