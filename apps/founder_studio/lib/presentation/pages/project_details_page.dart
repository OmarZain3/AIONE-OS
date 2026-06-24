import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:founder_studio/application/project/project_providers.dart';
import 'package:founder_studio/domain/project/project_status.dart';
import 'package:founder_studio/l10n/app_localizations.dart';
import 'package:founder_studio/presentation/widgets/delete_project_confirmation.dart';
import 'package:founder_studio/presentation/widgets/project_form_dialog.dart';
import 'package:founder_studio/presentation/widgets/project_icons.dart';

/// Full project detail view with edit and delete actions.
class ProjectDetailsPage extends ConsumerWidget {
  const ProjectDetailsPage({required this.projectId, super.key});

  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final projectAsync = ref.watch(projectDetailProvider(projectId));

    return projectAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.projectLoadError),
            const SizedBox(height: 8),
            Text(error.toString()),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => ref.invalidate(projectDetailProvider(projectId)),
              child: Text(l10n.retryAction),
            ),
          ],
        ),
      ),
      data: (project) {
        final accent = ProjectIcons.colorFromHex(project.color);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: accent.withValues(alpha: 0.15),
                      child: Icon(
                        ProjectIcons.fromName(project.icon),
                        color: accent,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        project.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(label: Text(_statusLabel(l10n, project.status))),
                    Chip(
                      label: Text(
                        l10n.projectUpdatedLabel(
                          MaterialLocalizations.of(
                            context,
                          ).formatShortDate(project.updatedAt),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (project.description.isNotEmpty) ...[
                  Text(
                    l10n.projectDescriptionLabel,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                ],
                Row(
                  children: [
                    FilledButton.icon(
                      onPressed: () =>
                          showEditProjectDialog(context, ref, project),
                      icon: const Icon(Icons.edit_outlined),
                      label: Text(l10n.editProjectAction),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () async {
                        final deleted = await showDeleteProjectConfirmation(
                          context,
                          ref,
                          project,
                        );
                        if (deleted && context.mounted) {
                          context.pop();
                        }
                      },
                      icon: const Icon(Icons.delete_outline),
                      label: Text(l10n.deleteProjectAction),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static String _statusLabel(AppLocalizations l10n, ProjectStatus status) {
    return switch (status) {
      ProjectStatus.draft => l10n.projectStatusDraft,
      ProjectStatus.active => l10n.projectStatusActive,
      ProjectStatus.onHold => l10n.projectStatusOnHold,
      ProjectStatus.archived => l10n.projectStatusArchived,
    };
  }
}
