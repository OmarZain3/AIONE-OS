import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:founder_studio/application/auth/auth_providers.dart';
import 'package:founder_studio/application/auth/auth_state.dart';
import 'package:founder_studio/l10n/app_localizations.dart';

/// Placeholder profile screen for the authenticated founder.
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);

    final user = authState is AuthAuthenticated ? authState.user : null;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(l10n.profileTitle, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 24),
        Center(
          child: CircleAvatar(
            radius: 48,
            child: Text(
              _initials(user?.fullName ?? user?.email ?? '?'),
              style: theme.textTheme.headlineMedium,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProfileField(
                  label: l10n.profileNameLabel,
                  value: user?.fullName ?? '—',
                ),
                const SizedBox(height: 12),
                _ProfileField(
                  label: l10n.loginEmailLabel,
                  value: user?.email ?? '—',
                ),
                const SizedBox(height: 12),
                _ProfileField(
                  label: l10n.profileStatusLabel,
                  value: user?.isActive == true
                      ? l10n.profileActive
                      : l10n.profileInactive,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.profilePlaceholderNote,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  String _initials(String value) {
    final parts = value.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return value.isNotEmpty ? value[0].toUpperCase() : '?';
  }
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelLarge),
        const SizedBox(height: 4),
        Text(value, style: theme.textTheme.titleMedium),
      ],
    );
  }
}
