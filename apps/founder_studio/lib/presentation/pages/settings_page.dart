import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:founder_studio/application/auth/auth_providers.dart';
import 'package:founder_studio/application/locale/locale_provider.dart';
import 'package:founder_studio/application/theme/theme_provider.dart';
import 'package:founder_studio/l10n/app_localizations.dart';
import 'package:founder_studio/presentation/widgets/backend_version_widget.dart';

/// Application settings including theme, language, and backend info.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          l10n.settingsTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.brightness_6_outlined),
                title: Text(l10n.settingsThemeLabel),
                subtitle: Text(_themeLabel(l10n, themeMode)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SegmentedButton<ThemeMode>(
                  segments: [
                    ButtonSegment(
                      value: ThemeMode.system,
                      label: Text(l10n.settingsThemeSystem),
                      icon: const Icon(Icons.brightness_auto),
                    ),
                    ButtonSegment(
                      value: ThemeMode.light,
                      label: Text(l10n.settingsThemeLight),
                      icon: const Icon(Icons.light_mode_outlined),
                    ),
                    ButtonSegment(
                      value: ThemeMode.dark,
                      label: Text(l10n.settingsThemeDark),
                      icon: const Icon(Icons.dark_mode_outlined),
                    ),
                  ],
                  selected: {themeMode},
                  onSelectionChanged: (selection) {
                    ref.read(themeModeProvider.notifier).state = selection.first;
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: const Icon(Icons.translate),
            title: Text(l10n.settingsLanguageLabel),
            subtitle: Text(
              locale.languageCode == 'ar'
                  ? l10n.languageArabic
                  : l10n.languageEnglish,
            ),
            trailing: Switch(
              value: locale.languageCode == 'ar',
              onChanged: (_) {
                final next = locale.languageCode == 'ar'
                    ? const Locale('en')
                    : const Locale('ar');
                ref.read(localeProvider.notifier).state = next;
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(child: const BackendVersionWidget()),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(l10n.logoutAction),
            onTap: () => ref.read(authProvider.notifier).logout(),
          ),
        ),
      ],
    );
  }

  String _themeLabel(AppLocalizations l10n, ThemeMode mode) {
    return switch (mode) {
      ThemeMode.light => l10n.settingsThemeLight,
      ThemeMode.dark => l10n.settingsThemeDark,
      ThemeMode.system => l10n.settingsThemeSystem,
    };
  }
}
