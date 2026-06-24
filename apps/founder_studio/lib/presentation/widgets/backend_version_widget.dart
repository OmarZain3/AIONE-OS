import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:founder_studio/application/health/backend_version_provider.dart';
import 'package:founder_studio/l10n/app_localizations.dart';

/// Displays backend version and environment from the health endpoint.
class BackendVersionWidget extends ConsumerWidget {
  const BackendVersionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final versionAsync = ref.watch(backendVersionProvider);
    final theme = Theme.of(context);

    return versionAsync.when(
      loading: () => ListTile(
        leading: const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        title: Text(l10n.backendVersionLabel),
        subtitle: Text(l10n.connectionChecking),
      ),
      error: (_, _) => ListTile(
        leading: Icon(Icons.info_outline, color: theme.colorScheme.outline),
        title: Text(l10n.backendVersionLabel),
        subtitle: Text(l10n.backendVersionUnavailable),
      ),
      data: (info) => ListTile(
        leading: Icon(
          info.isReachable ? Icons.verified_outlined : Icons.info_outline,
          color: info.isReachable
              ? theme.colorScheme.primary
              : theme.colorScheme.outline,
        ),
        title: Text(l10n.backendVersionLabel),
        subtitle: Text(
          info.isReachable
              ? '${info.version} · ${info.environment}'
              : l10n.backendVersionUnavailable,
        ),
      ),
    );
  }
}
