import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:founder_studio/application/auth/auth_providers.dart';
import 'package:founder_studio/application/project/project_use_cases.dart';
import 'package:founder_studio/domain/project/project.dart';
import 'package:founder_studio/domain/project/project_repository.dart';
import 'package:founder_studio/domain/project/project_status.dart';
import 'package:founder_studio/infrastructure/project/project_api_client.dart';
import 'package:founder_studio/infrastructure/project/project_repository_impl.dart';

final projectApiClientProvider = Provider<ProjectApiClient>((ref) {
  final httpClient = ref.watch(authenticatedHttpClientProvider);
  return ProjectApiClient(client: httpClient);
});

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  return ProjectRepositoryImpl(apiClient: ref.watch(projectApiClientProvider));
});

final listProjectsUseCaseProvider = Provider<ListProjectsUseCase>((ref) {
  return ListProjectsUseCase(ref.watch(projectRepositoryProvider));
});

final getProjectUseCaseProvider = Provider<GetProjectUseCase>((ref) {
  return GetProjectUseCase(ref.watch(projectRepositoryProvider));
});

final createProjectUseCaseProvider = Provider<CreateProjectUseCase>((ref) {
  return CreateProjectUseCase(ref.watch(projectRepositoryProvider));
});

final updateProjectUseCaseProvider = Provider<UpdateProjectUseCase>((ref) {
  return UpdateProjectUseCase(ref.watch(projectRepositoryProvider));
});

final deleteProjectUseCaseProvider = Provider<DeleteProjectUseCase>((ref) {
  return DeleteProjectUseCase(ref.watch(projectRepositoryProvider));
});

/// Filter state for the project list.
class ProjectListFilter {
  const ProjectListFilter({this.search = '', this.status});

  final String search;
  final ProjectStatus? status;

  ProjectListFilter copyWith({String? search, ProjectStatus? status}) {
    return ProjectListFilter(search: search ?? this.search, status: status);
  }
}

final projectListFilterProvider = StateProvider<ProjectListFilter>(
  (ref) => const ProjectListFilter(),
);

final projectListProvider = FutureProvider.autoDispose<PaginatedProjects>((
  ref,
) async {
  final filter = ref.watch(projectListFilterProvider);
  final useCase = ref.watch(listProjectsUseCaseProvider);
  return useCase(
    ProjectListQuery(
      search: filter.search.isEmpty ? null : filter.search,
      status: filter.status,
    ),
  );
});

final projectDetailProvider = FutureProvider.autoDispose
    .family<Project, String>((ref, id) async {
      final useCase = ref.watch(getProjectUseCaseProvider);
      return useCase(id);
    });

/// Orchestrates project mutations and list refresh.
class ProjectActions {
  ProjectActions(this._ref);

  final Ref _ref;

  Future<Project> create(Project project) async {
    final created = await _ref.read(createProjectUseCaseProvider).call(project);
    _ref.invalidate(projectListProvider);
    return created;
  }

  Future<Project> update(Project project) async {
    final updated = await _ref.read(updateProjectUseCaseProvider).call(project);
    _ref.invalidate(projectListProvider);
    _ref.invalidate(projectDetailProvider(project.id));
    return updated;
  }

  Future<void> delete(String id) async {
    await _ref.read(deleteProjectUseCaseProvider).call(id);
    _ref.invalidate(projectListProvider);
    _ref.invalidate(projectDetailProvider(id));
  }
}

final projectActionsProvider = Provider<ProjectActions>((ref) {
  return ProjectActions(ref);
});
