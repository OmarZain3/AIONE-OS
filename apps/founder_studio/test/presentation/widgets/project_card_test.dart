import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:founder_studio/domain/project/project.dart';
import 'package:founder_studio/domain/project/project_status.dart';
import 'package:founder_studio/l10n/app_localizations.dart';
import 'package:founder_studio/presentation/widgets/project_card.dart';

void main() {
  final project = Project(
    id: '11111111-1111-1111-1111-111111111111',
    name: 'Venture Alpha',
    description: 'Building the future',
    status: ProjectStatus.active,
    color: '#6366F1',
    icon: 'rocket_launch',
    createdBy: '22222222-2222-2222-2222-222222222222',
    createdAt: DateTime.utc(2026, 6, 24),
    updatedAt: DateTime.utc(2026, 6, 24),
  );

  Widget wrap(Widget child) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    );
  }

  testWidgets('ProjectCard displays name and description', (tester) async {
    await tester.pumpWidget(
      wrap(
        ProjectCard(project: project, onTap: () {}),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Venture Alpha'), findsOneWidget);
    expect(find.text('Building the future'), findsOneWidget);
    expect(find.text('Active'), findsOneWidget);
  });

  testWidgets('ProjectCard triggers onTap', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      wrap(
        ProjectCard(project: project, onTap: () => tapped = true),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Venture Alpha'));
    expect(tapped, isTrue);
  });
}
