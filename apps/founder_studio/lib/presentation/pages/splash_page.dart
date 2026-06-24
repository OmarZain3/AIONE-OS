import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:founder_studio/application/auth/auth_providers.dart';
import 'package:founder_studio/l10n/app_localizations.dart';

/// Initial splash screen — restores session before routing.
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authProvider.notifier).restoreSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.hub_outlined,
              size: 72,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(l10n.appTitle, style: theme.textTheme.headlineMedium),
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(l10n.splashLoading, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
