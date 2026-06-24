import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:founder_studio/l10n/app_localizations.dart';
import 'package:founder_studio/presentation/widgets/empty_project_state.dart';

void main() {
  testWidgets('EmptyProjectState shows create action', (tester) async {
    var createTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: EmptyProjectState(onCreate: () => createTapped = true),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No projects yet'), findsOneWidget);
    await tester.tap(find.text('Create project'));
    expect(createTapped, isTrue);
  });
}
