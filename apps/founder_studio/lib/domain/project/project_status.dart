/// Lifecycle status for a venture project.
enum ProjectStatus {
  draft('draft'),
  active('active'),
  onHold('on_hold'),
  archived('archived');

  const ProjectStatus(this.apiValue);

  final String apiValue;

  static ProjectStatus fromApiValue(String value) {
    return ProjectStatus.values.firstWhere(
      (status) => status.apiValue == value,
      orElse: () => ProjectStatus.draft,
    );
  }
}
