import 'package:flutter/material.dart';
import 'package:flutter_application_2/theme/btnApp.dart';
import 'package:flutter_application_2/components/btn_style.dart';

import '../enums/btn_variant.dart';
import 'btn_style.dart';

class AppButtonStyleResolver {
  static AppButtonStyle resolve(BtnVariant variant) {
    switch (variant) {
      case BtnVariant.danger:
        return AppButtonStyle(
          background: AppColors.danger.withValues(alpha: 0.1),
          textColor: AppColors.danger,
        );
      case BtnVariant.normal:
      default:
        return AppButtonStyle(
          background: Colors.blueGrey.withValues(alpha: 0.1),
          textColor: AppColors.textMain,
        );
    }
  }
}
