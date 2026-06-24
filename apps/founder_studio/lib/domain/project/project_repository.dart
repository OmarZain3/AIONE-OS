import 'package:founder_studio/domain/project/project.dart';
import 'package:founder_studio/domain/project/project_status.dart';

/// Paginated project list from the API.
class PaginatedProjects {
  const PaginatedProjects({
    required this.count,
    required this.results,
    this.next,
    this.previous,
  });

  final int count;
  final List<Project> results;
  final String? next;
  final String? previous;
}

/// Query parameters for listing projects.
class ProjectListQuery {
  const ProjectListQuery({
    this.search,
    this.status,
    this.page = 1,
    this.ordering = '-updated_at',
  });

  final String? search;
  final ProjectStatus? status;
  final int page;
  final String ordering;
}

/// Contract for project persistence and retrieval.
abstract class ProjectRepository {
  Future<PaginatedProjects> listProjects(ProjectListQuery query);

  Future<Project> getProject(String id);

  Future<Project> createProject(Project project);

  Future<Project> updateProject(Project project);

  Future<void> deleteProject(String id);
}
