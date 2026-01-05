import 'package:flutter/material.dart';
import 'package:flutter_application_2/theme/btnApp.dart';

class AppButtonStyle {
  final Color background;
  final Color textColor;
  final EdgeInsets padding;
  final double radius;

  const AppButtonStyle({
    required this.background,
    required this.textColor,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.md,
    ),
    this.radius = AppRadius.md,
  });
}
