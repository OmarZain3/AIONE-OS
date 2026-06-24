import 'package:founder_studio/domain/project/project.dart';
import 'package:founder_studio/domain/project/project_repository.dart';
import 'package:founder_studio/infrastructure/project/project_api_client.dart';

/// Infrastructure implementation of [ProjectRepository].
class ProjectRepositoryImpl implements ProjectRepository {
  ProjectRepositoryImpl({required ProjectApiClient apiClient})
    : _apiClient = apiClient;

  final ProjectApiClient _apiClient;

  @override
  Future<PaginatedProjects> listProjects(ProjectListQuery query) {
    return _apiClient.listProjects(query);
  }

  @override
  Future<Project> getProject(String id) {
    return _apiClient.getProject(id);
  }

  @override
  Future<Project> createProject(Project project) {
    return _apiClient.createProject(project);
  }

  @override
  Future<Project> updateProject(Project project) {
    return _apiClient.updateProject(project);
  }

  @override
  Future<void> deleteProject(String id) {
    return _apiClient.deleteProject(id);
  }
}
