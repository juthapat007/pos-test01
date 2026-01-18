import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/btn_style.dart';
import 'package:flutter_application_2/components/logic_bnt_style.dart';
import 'package:flutter_application_2/config/cons.dart';
import 'package:flutter_application_2/enums/btn_variant.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final BtnVariant variant;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.variant = BtnVariant.normal,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppButtonStyleResolver.resolve(variant);

    if (style.outlined) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon != null
            ? Icon(icon, color: style.textColor)
            : const SizedBox.shrink(),
        label: Text(text),
        style: OutlinedButton.styleFrom(
          foregroundColor: style.textColor,
          side: BorderSide(
            color: style.borderColor, // เส้นขอบ
            width: style.borderWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: HeightSpacing.hxl,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(style.radius),
            child: Ink(
              decoration: BoxDecoration(
                color: style.background,
                borderRadius: BorderRadius.circular(style.radius),
              ),
              child: Padding(
                padding: style.padding,
                child: _buildContent(style),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(AppButtonStyle style) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20, color: style.textColor),
          const SizedBox(width: TextSpacing.md),
        ],
        Flexible(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: TextSpacing.sm,
              fontWeight: FontWeight.bold,
              color: style.textColor,
            ),
          ),
        ),
      ],
    );
  }
}

BoxDecoration decoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(6),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.2),
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ],
  );
}
