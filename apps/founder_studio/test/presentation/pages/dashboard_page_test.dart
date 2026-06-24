import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:founder_studio/application/project/project_providers.dart';
import 'package:founder_studio/domain/project/project.dart';
import 'package:founder_studio/domain/project/project_repository.dart';
import 'package:founder_studio/l10n/app_localizations.dart';
import 'package:founder_studio/presentation/pages/dashboard_page.dart';

class _FakeProjectRepository implements ProjectRepository {
  @override
  Future<Project> createProject(Project project) async => project;

  @override
  Future<void> deleteProject(String id) async {}

  @override
  Future<Project> getProject(String id) async {
    throw UnimplementedError();
  }

  @override
  Future<PaginatedProjects> listProjects(ProjectListQuery query) async {
    return const PaginatedProjects(count: 0, results: []);
  }

  @override
  Future<Project> updateProject(Project project) async => project;
}

void main() {
  Widget wrap(Widget child) {
    return ProviderScope(
      overrides: [
        projectRepositoryProvider.overrideWithValue(_FakeProjectRepository()),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: child),
      ),
    );
  }

  testWidgets('DashboardPage shows empty project state when list is empty', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const DashboardPage()));
    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('No projects yet'), findsOneWidget);
    expect(find.text('Search projects…'), findsOneWidget);
  });
}
