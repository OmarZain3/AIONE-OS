import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:founder_studio/application/health/health_providers.dart';
import 'package:founder_studio/application/locale/locale_provider.dart';
import 'package:founder_studio/l10n/app_localizations.dart';

/// Displays local and backend health status.
class HealthPage extends ConsumerWidget {
  const HealthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final healthAsync = ref.watch(healthStatusProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.healthTitle),
        actions: [
          IconButton(
            tooltip: locale.languageCode == 'ar' ? 'English' : 'العربية',
            onPressed: () {
              final next = locale.languageCode == 'ar'
                  ? const Locale('en')
                  : const Locale('ar');
              ref.read(localeProvider.notifier).state = next;
            },
            icon: const Icon(Icons.translate),
          ),
        ],
      ),
      body: healthAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
        data: (status) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HealthCard(
                label: l10n.healthStatusLabel,
                value: status.isHealthy
                    ? l10n.healthStatusOk
                    : l10n.healthStatusUnknown,
                icon: Icons.verified_outlined,
              ),
              const SizedBox(height: 16),
              _HealthCard(
                label: l10n.healthBackendLabel,
                value: status.backendReachable
                    ? l10n.healthBackendReachable
                    : l10n.healthBackendUnreachable,
                icon: Icons.cloud_outlined,
              ),
              const SizedBox(height: 16),
              _HealthCard(
                label: 'Version',
                value: status.version,
                icon: Icons.info_outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HealthCard extends StatelessWidget {
  const _HealthCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: theme.textTheme.labelLarge),
                  const SizedBox(height: 4),
                  Text(value, style: theme.textTheme.titleMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
