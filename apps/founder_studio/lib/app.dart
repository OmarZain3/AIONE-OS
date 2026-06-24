import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:founder_studio/application/auth/auth_providers.dart';
import 'package:founder_studio/application/auth/auth_state.dart';
import 'package:founder_studio/application/locale/locale_provider.dart';
import 'package:founder_studio/application/theme/theme_provider.dart';
import 'package:founder_studio/l10n/app_localizations.dart';
import 'package:founder_studio/presentation/router/app_router.dart';
import 'package:founder_studio/presentation/theme/app_theme.dart';

/// Root application widget.
class FounderStudioApp extends ConsumerWidget {
  const FounderStudioApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Founder Studio',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final router = AppRouter.createRouter(ref);

  ref.listen<AuthState>(authProvider, (_, _) {
    router.refresh();
  });

  return router;
});
