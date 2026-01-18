import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF0C0F1E);

  static const danger = Color(0xFFE53935);

  static const textMain = Color(0xFF143041);
  static const border = Color(0xFFE2773A);
static const base = Color.fromARGB(255, 245, 237, 226);
  static const background = Color(0xFFCB6B68);
  static const choose = Color(0xFF68504C);
}

class AppTextStyles {
  static const title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textMain,
  );

  static const body = TextStyle(fontSize: 14, color: AppColors.textMain);

  static const button = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
}

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      textTheme: const TextTheme(bodyMedium: AppTextStyles.body),
    );
  }
}

class AppRadius {
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
}

class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
}
