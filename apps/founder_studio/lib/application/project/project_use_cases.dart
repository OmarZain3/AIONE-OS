import 'package:founder_studio/domain/project/project.dart';
import 'package:founder_studio/domain/project/project_repository.dart';

/// Loads a paginated list of projects.
class ListProjectsUseCase {
  ListProjectsUseCase(this._repository);

  final ProjectRepository _repository;

  Future<PaginatedProjects> call(ProjectListQuery query) {
    return _repository.listProjects(query);
  }
}

/// Loads a single project by id.
class GetProjectUseCase {
  GetProjectUseCase(this._repository);

  final ProjectRepository _repository;

  Future<Project> call(String id) {
    return _repository.getProject(id);
  }
}

/// Creates a new project.
class CreateProjectUseCase {
  CreateProjectUseCase(this._repository);

  final ProjectRepository _repository;

  Future<Project> call(Project project) {
    return _repository.createProject(project);
  }
}

/// Updates an existing project.
class UpdateProjectUseCase {
  UpdateProjectUseCase(this._repository);

  final ProjectRepository _repository;

  Future<Project> call(Project project) {
    return _repository.updateProject(project);
  }
}

/// Deletes a project.
class DeleteProjectUseCase {
  DeleteProjectUseCase(this._repository);

  final ProjectRepository _repository;

  Future<void> call(String id) {
    return _repository.deleteProject(id);
  }
}
