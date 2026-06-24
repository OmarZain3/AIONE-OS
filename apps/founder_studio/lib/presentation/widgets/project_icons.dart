import 'package:flutter/material.dart';

/// Maps API icon names to Material icons.
abstract final class ProjectIcons {
  static const available = [
    'rocket_launch',
    'lightbulb',
    'business',
    'code',
    'science',
    'storefront',
    'groups',
    'trending_up',
  ];

  static IconData fromName(String name) {
    return switch (name) {
      'lightbulb' => Icons.lightbulb_outline,
      'business' => Icons.business_outlined,
      'code' => Icons.code,
      'science' => Icons.science_outlined,
      'storefront' => Icons.storefront_outlined,
      'groups' => Icons.groups_outlined,
      'trending_up' => Icons.trending_up,
      _ => Icons.rocket_launch_outlined,
    };
  }

  static Color colorFromHex(String hex) {
    var value = hex.replaceFirst('#', '');
    if (value.length == 3) {
      value = value.split('').map((c) => '$c$c').join();
    }
    return Color(int.parse('FF$value', radix: 16));
  }
}
