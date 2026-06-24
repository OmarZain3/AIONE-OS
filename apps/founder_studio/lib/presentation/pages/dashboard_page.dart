import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:founder_studio/l10n/app_localizations.dart';
import 'package:founder_studio/presentation/widgets/connection_status_widget.dart';
import 'package:founder_studio/presentation/widgets/project_list.dart';

/// Founder dashboard with project list and connection status.
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  l10n.dashboardTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const ConnectionStatusWidget(compact: true),
            ],
          ),
        ),
        const Expanded(child: ProjectList()),
      ],
    );
  }
}
