import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:founder_studio/application/project/project_providers.dart';
import 'package:founder_studio/l10n/app_localizations.dart';
import 'package:founder_studio/presentation/router/app_router.dart';
import 'package:founder_studio/presentation/widgets/empty_project_state.dart';
import 'package:founder_studio/presentation/widgets/project_card.dart';
import 'package:founder_studio/presentation/widgets/project_form_dialog.dart';

/// Responsive project grid with search and create action.
class ProjectList extends ConsumerWidget {
  const ProjectList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final projectsAsync = ref.watch(projectListProvider);
    final filter = ref.watch(projectListFilterProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: l10n.projectSearchHint,
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                  onChanged: (value) {
                    ref.read(projectListFilterProvider.notifier).state = filter
                        .copyWith(search: value);
                  },
                ),
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: () => showCreateProjectDialog(context, ref),
                icon: const Icon(Icons.add),
                label: Text(l10n.createProjectAction),
              ),
            ],
          ),
        ),
        Expanded(
          child: projectsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(l10n.projectLoadError),
                    const SizedBox(height: 8),
                    Text(error.toString(), textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => ref.invalidate(projectListProvider),
                      child: Text(l10n.retryAction),
                    ),
                  ],
                ),
              ),
            ),
            data: (page) {
              if (page.results.isEmpty) {
                return EmptyProjectState(
                  onCreate: () => showCreateProjectDialog(context, ref),
                );
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final crossAxisCount = width >= 1200
                      ? 4
                      : width >= 900
                      ? 3
                      : width >= 600
                      ? 2
                      : 1;

                  return GridView.builder(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: crossAxisCount == 1 ? 2.4 : 1.2,
                    ),
                    itemCount: page.results.length,
                    itemBuilder: (context, index) {
                      final project = page.results[index];
                      return ProjectCard(
                        project: project,
                        onTap: () =>
                            context.push(AppRoutes.projectDetail(project.id)),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
