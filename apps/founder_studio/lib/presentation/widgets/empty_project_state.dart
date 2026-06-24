import 'package:flutter/material.dart';

import 'package:founder_studio/l10n/app_localizations.dart';

/// Placeholder shown when the founder has no projects yet.
class EmptyProjectState extends StatelessWidget {
  const EmptyProjectState({this.onCreate, super.key});

  final VoidCallback? onCreate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.rocket_launch_outlined,
                size: 72,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                l10n.emptyProjectsTitle,
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.emptyProjectsDescription,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onCreate,
                icon: const Icon(Icons.add),
                label: Text(l10n.emptyProjectsAction),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
