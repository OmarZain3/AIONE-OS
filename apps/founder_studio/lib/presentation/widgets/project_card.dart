import 'package:flutter/material.dart';

import 'package:founder_studio/domain/project/project.dart';
import 'package:founder_studio/domain/project/project_status.dart';
import 'package:founder_studio/l10n/app_localizations.dart';
import 'package:founder_studio/presentation/widgets/project_icons.dart';

/// Card displaying a project summary in the grid.
class ProjectCard extends StatelessWidget {
  const ProjectCard({required this.project, required this.onTap, super.key});

  final Project project;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final accent = ProjectIcons.colorFromHex(project.color);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: accent.withValues(alpha: 0.15),
                    child: Icon(
                      ProjectIcons.fromName(project.icon),
                      color: accent,
                    ),
                  ),
                  const Spacer(),
                  _StatusChip(status: project.status, label: _statusLabel(l10n, project.status)),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                project.name,
                style: theme.textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (project.description.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  project.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
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

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status, required this.label});

  final ProjectStatus status;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
