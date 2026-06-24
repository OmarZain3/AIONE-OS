import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:founder_studio/application/project/project_providers.dart';
import 'package:founder_studio/domain/project/project.dart';
import 'package:founder_studio/infrastructure/project/project_api_client.dart';
import 'package:founder_studio/l10n/app_localizations.dart';

/// Confirms permanent project deletion.
Future<bool> showDeleteProjectConfirmation(
  BuildContext context,
  WidgetRef ref,
  Project project,
) async {
  final l10n = AppLocalizations.of(context);
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(l10n.deleteProjectTitle),
        content: Text(l10n.deleteProjectMessage(project.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancelAction),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.deleteProjectAction),
          ),
        ],
      );
    },
  );

  if (confirmed != true || !context.mounted) {
    return false;
  }

  try {
    await ref.read(projectActionsProvider).delete(project.id);
    return true;
  } on ProjectApiException catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.message)));
    }
    return false;
  }
}
