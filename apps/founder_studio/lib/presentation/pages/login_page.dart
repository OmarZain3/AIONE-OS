import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:founder_studio/application/auth/auth_providers.dart';
import 'package:founder_studio/application/auth/auth_state.dart';
import 'package:founder_studio/l10n/app_localizations.dart';
import 'package:founder_studio/presentation/router/app_router.dart';

/// Email and password sign-in screen.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    await ref
        .read(authProvider.notifier)
        .login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next is AuthAuthenticated) {
        context.go(AppRoutes.dashboard);
      }
    });

    final isLoading = authState is AuthLoading;
    final errorMessage = authState is AuthError ? authState.message : null;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.hub_outlined,
                    size: 56,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.appTitle,
                    style: theme.textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.loginSubtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  if (errorMessage != null) ...[
                    MaterialBanner(
                      content: Text(errorMessage),
                      leading: Icon(
                        Icons.error_outline,
                        color: theme.colorScheme.error,
                      ),
                      backgroundColor: theme.colorScheme.errorContainer,
                      actions: [
                        TextButton(onPressed: () {}, child: Text(l10n.dismiss)),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    decoration: InputDecoration(
                      labelText: l10n.loginEmailLabel,
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.loginEmailRequired;
                      }
                      return null;
                    },
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    autofillHints: const [AutofillHints.password],
                    decoration: InputDecoration(
                      labelText: l10n.loginPasswordLabel,
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: isLoading
                            ? null
                            : () => setState(
                                () => _obscurePassword = !_obscurePassword,
                              ),
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.loginPasswordRequired;
                      }
                      return null;
                    },
                    enabled: !isLoading,
                    onFieldSubmitted: (_) => _submit(),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: isLoading ? null : _submit,
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.loginAction),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
