import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:founder_studio/application/health/health_providers.dart';
import 'package:founder_studio/l10n/app_localizations.dart';

/// Displays backend connectivity status.
class ConnectionStatusWidget extends ConsumerWidget {
  const ConnectionStatusWidget({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final healthAsync = ref.watch(healthStatusProvider);
    final theme = Theme.of(context);

    return healthAsync.when(
      loading: () => _StatusChip(
        label: l10n.connectionChecking,
        color: theme.colorScheme.outline,
        icon: Icons.sync,
        compact: compact,
      ),
      error: (_, _) => _StatusChip(
        label: l10n.connectionOffline,
        color: theme.colorScheme.error,
        icon: Icons.cloud_off_outlined,
        compact: compact,
      ),
      data: (status) {
        final connected = status.backendReachable;
        return _StatusChip(
          label: connected ? l10n.connectionOnline : l10n.connectionOffline,
          color: connected ? Colors.green : theme.colorScheme.error,
          icon: connected
              ? Icons.cloud_done_outlined
              : Icons.cloud_off_outlined,
          compact: compact,
        );
      },
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.color,
    required this.icon,
    required this.compact,
  });

  final String label;
  final Color color;
  final IconData icon;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Tooltip(
        message: label,
        child: Icon(icon, size: 18, color: color),
      );
    }

    return Chip(
      avatar: Icon(icon, size: 18, color: color),
      label: Text(label),
      side: BorderSide(color: color.withValues(alpha: 0.4)),
    );
  }
}
