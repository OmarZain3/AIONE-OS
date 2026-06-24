import 'package:flutter_test/flutter_test.dart';

import 'package:founder_studio/domain/project/project.dart';
import 'package:founder_studio/domain/project/project_status.dart';

void main() {
  test('Project.fromJson parses API payload', () {
    final project = Project.fromJson({
      'id': '11111111-1111-1111-1111-111111111111',
      'name': 'Alpha',
      'description': 'First venture',
      'status': 'active',
      'color': '#6366F1',
      'icon': 'rocket_launch',
      'created_by': '22222222-2222-2222-2222-222222222222',
      'created_at': '2026-06-24T10:00:00Z',
      'updated_at': '2026-06-24T12:00:00Z',
    });

    expect(project.name, 'Alpha');
    expect(project.status, ProjectStatus.active);
    expect(project.color, '#6366F1');
  });

  test('toCreateJson serializes writable fields', () {
    final project = Project(
      id: '',
      name: 'Beta',
      description: 'Desc',
      status: ProjectStatus.draft,
      color: '#FF5733',
      icon: 'code',
      createdBy: '',
      createdAt: DateTime.utc(2026),
      updatedAt: DateTime.utc(2026),
    );

    final json = project.toCreateJson();

    expect(json['name'], 'Beta');
    expect(json['status'], 'draft');
    expect(json['icon'], 'code');
  });
}
