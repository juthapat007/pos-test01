import 'package:flutter/material.dart';
import 'package:flutter_application_2/theme/btnApp.dart';

class AppButtonStyle {
  final Color background;
  final Color textColor;
  final EdgeInsets padding;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final bool outlined;

  const AppButtonStyle({
    required this.background,
    required this.textColor,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    this.outlined = false,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.md,
    ),
    this.radius = AppRadius.md,
  });
}

// class AppButtonStyle {
//   final Color background;
//   final Color textColor;
//   final EdgeInsets padding;
//   final double radius;
//   final Color borderColor;
//   final double borderWidth;
//   final bool outlined;

//   const AppButtonStyle({
//     required this.padding,
//     required this.background,
//     required this.textColor,
//     this.borderColor = Colors.transparent,
//     this.borderWidth = 0,
//     this.outlined = false,
//     this.radius = AppRadius.md,
//   });
// }
