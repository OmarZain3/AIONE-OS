import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:founder_studio/application/project/project_providers.dart';
import 'package:founder_studio/domain/project/project.dart';
import 'package:founder_studio/domain/project/project_status.dart';
import 'package:founder_studio/infrastructure/project/project_api_client.dart';
import 'package:founder_studio/l10n/app_localizations.dart';
import 'package:founder_studio/presentation/widgets/project_icons.dart';

/// Shared form fields for create and edit project dialogs.
class ProjectForm extends StatefulWidget {
  const ProjectForm({
    required this.initialName,
    required this.initialDescription,
    required this.initialStatus,
    required this.initialColor,
    required this.initialIcon,
    required this.onSubmit,
    required this.submitLabel,
    super.key,
  });

  final String initialName;
  final String initialDescription;
  final ProjectStatus initialStatus;
  final String initialColor;
  final String initialIcon;
  final Future<void> Function({
    required String name,
    required String description,
    required ProjectStatus status,
    required String color,
    required String icon,
  })
  onSubmit;
  final String submitLabel;

  @override
  State<ProjectForm> createState() => ProjectFormState();
}

class ProjectFormState extends State<ProjectForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late ProjectStatus _status;
  late String _color;
  late String _icon;
  bool _submitting = false;
  String? _error;

  static const _colorOptions = [
    '#6366F1',
    '#EC4899',
    '#10B981',
    '#F59E0B',
    '#3B82F6',
    '#8B5CF6',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _descriptionController = TextEditingController(
      text: widget.initialDescription,
    );
    _status = widget.initialStatus;
    _color = widget.initialColor;
    _icon = widget.initialIcon;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await widget.onSubmit(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        status: _status,
        color: _color,
        icon: _icon,
      );
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } on ProjectApiException catch (error) {
      setState(() => _error = error.message);
    } catch (error) {
      setState(() => _error = error.toString());
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: l10n.projectNameLabel),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.projectNameRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: l10n.projectDescriptionLabel,
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<ProjectStatus>(
            initialValue: _status,
            decoration: InputDecoration(labelText: l10n.projectStatusLabel),
            items: ProjectStatus.values
                .map(
                  (status) => DropdownMenuItem(
                    value: status,
                    child: Text(_statusLabel(l10n, status)),
                  ),
                )
                .toList(),
            onChanged: _submitting
                ? null
                : (value) {
                    if (value != null) {
                      setState(() => _status = value);
                    }
                  },
          ),
          const SizedBox(height: 12),
          Text(
            l10n.projectColorLabel,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final color in _colorOptions)
                ChoiceChip(
                  selected: _color == color,
                  onSelected: _submitting
                      ? null
                      : (_) => setState(() => _color = color),
                  label: const SizedBox(width: 8, height: 8),
                  avatar: CircleAvatar(
                    backgroundColor: ProjectIcons.colorFromHex(color),
                    radius: 8,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _icon,
            decoration: InputDecoration(labelText: l10n.projectIconLabel),
            items: ProjectIcons.available
                .map(
                  (icon) => DropdownMenuItem(
                    value: icon,
                    child: Row(
                      children: [
                        Icon(ProjectIcons.fromName(icon)),
                        const SizedBox(width: 8),
                        Text(icon),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: _submitting
                ? null
                : (value) {
                    if (value != null) {
                      setState(() => _icon = value);
                    }
                  },
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(
              _error!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _submitting ? null : _submit,
            child: _submitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(widget.submitLabel),
          ),
        ],
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

Future<bool?> showCreateProjectDialog(BuildContext context, WidgetRef ref) {
  final l10n = AppLocalizations.of(context);
  final actions = ref.read(projectActionsProvider);

  return showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(l10n.createProjectTitle),
        content: SingleChildScrollView(
          child: ProjectForm(
            initialName: '',
            initialDescription: '',
            initialStatus: ProjectStatus.draft,
            initialColor: '#6366F1',
            initialIcon: 'rocket_launch',
            submitLabel: l10n.createProjectAction,
            onSubmit:
                ({
                  required String name,
                  required String description,
                  required ProjectStatus status,
                  required String color,
                  required String icon,
                }) async {
                  final draft = Project(
                    id: '',
                    name: name,
                    description: description,
                    status: status,
                    color: color,
                    icon: icon,
                    createdBy: '',
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  );
                  await actions.create(draft);
                },
          ),
        ),
      );
    },
  );
}

Future<bool?> showEditProjectDialog(
  BuildContext context,
  WidgetRef ref,
  Project project,
) {
  final l10n = AppLocalizations.of(context);
  final actions = ref.read(projectActionsProvider);

  return showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(l10n.editProjectTitle),
        content: SingleChildScrollView(
          child: ProjectForm(
            initialName: project.name,
            initialDescription: project.description,
            initialStatus: project.status,
            initialColor: project.color,
            initialIcon: project.icon,
            submitLabel: l10n.saveProjectAction,
            onSubmit:
                ({
                  required String name,
                  required String description,
                  required ProjectStatus status,
                  required String color,
                  required String icon,
                }) async {
                  await actions.update(
                    project.copyWith(
                      name: name,
                      description: description,
                      status: status,
                      color: color,
                      icon: icon,
                    ),
                  );
                },
          ),
        ),
      );
    },
  );
}
