import 'package:founder_studio/domain/project/project_status.dart';

/// Founder venture project entity.
class Project {
  const Project({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.color,
    required this.icon,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String description;
  final ProjectStatus status;
  final String color;
  final String icon;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      status: ProjectStatus.fromApiValue(json['status'] as String),
      color: json['color'] as String? ?? '#6366F1',
      icon: json['icon'] as String? ?? 'rocket_launch',
      createdBy: json['created_by'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'name': name,
      'description': description,
      'status': status.apiValue,
      'color': color,
      'icon': icon,
    };
  }

  Map<String, dynamic> toUpdateJson() => toCreateJson();

  Project copyWith({
    String? name,
    String? description,
    ProjectStatus? status,
    String? color,
    String? icon,
  }) {
    return Project(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      status: status ?? this.status,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      createdBy: createdBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
