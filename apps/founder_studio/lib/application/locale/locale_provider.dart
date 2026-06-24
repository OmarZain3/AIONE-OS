import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Active application locale (supports RTL via Arabic).
final localeProvider = StateProvider<Locale>((ref) => const Locale('en'));
