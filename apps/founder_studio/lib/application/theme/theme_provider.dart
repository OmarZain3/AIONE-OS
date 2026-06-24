import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Active theme mode for the application.
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
