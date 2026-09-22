import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_dimensions.dart';
import '../core/theme/app_text_styles.dart';

/// Button variant types.
enum AppButtonVariant { primary, secondary, outline, ghost, danger }

/// Reusable button widget for the app.
/// Supports: primary, secondary, outline, ghost, danger variants.
/// Supports: loading state, disabled state, icon, full-width or custom width.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.label,
    this.text,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.width,
    this.height = AppDimensions.buttonHeightLg,
    this.borderRadius = AppDimensions.radiusMd,
  });

  final String? label;
  final String? text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  final double? width;
  final double height;
  final double borderRadius;

  String get _buttonText => label ?? text ?? '';
  bool get _isEnabled => !isLoading && !isDisabled && onPressed != null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    switch (variant) {
      case AppButtonVariant.primary:
        return _PrimaryButton(
          label: _buttonText,
          onPressed: _isEnabled ? onPressed : null,
          isLoading: isLoading,
          icon: icon,
          borderRadius: borderRadius,
        );
      case AppButtonVariant.secondary:
        return _SecondaryButton(
          label: _buttonText,
          onPressed: _isEnabled ? onPressed : null,
          isLoading: isLoading,
          icon: icon,
          borderRadius: borderRadius,
        );
      case AppButtonVariant.outline:
        return _OutlineButton(
          label: _buttonText,
          onPressed: _isEnabled ? onPressed : null,
          isLoading: isLoading,
          icon: icon,
          borderRadius: borderRadius,
        );
      case AppButtonVariant.ghost:
        return _GhostButton(
          label: _buttonText,
          onPressed: _isEnabled ? onPressed : null,
          isLoading: isLoading,
          icon: icon,
          borderRadius: borderRadius,
        );
      case AppButtonVariant.danger:
        return _DangerButton(
          label: _buttonText,
          onPressed: _isEnabled ? onPressed : null,
          isLoading: isLoading,
          icon: icon,
          borderRadius: borderRadius,
        );
    }
  }
}

// ─── Primary Button ──────────────────────────────────────────────────────────
class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.onPressed,
    required this.isLoading,
    required this.borderRadius,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed == null
            ? AppColors.primary.withValues(alpha: 0.5)
            : AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: _ButtonContent(
        label: label,
        icon: icon,
        isLoading: isLoading,
        textStyle: AppTextStyles.buttonLarge,
        loaderColor: AppColors.textOnPrimary,
      ),
    );
  }
}

// ─── Secondary Button ────────────────────────────────────────────────────────
class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({
    required this.label,
    required this.onPressed,
    required this.isLoading,
    required this.borderRadius,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight.withValues(alpha: 0.12),
        foregroundColor: AppColors.primary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: _ButtonContent(
        label: label,
        icon: icon,
        isLoading: isLoading,
        textStyle: AppTextStyles.buttonLarge,
        loaderColor: AppColors.primary,
      ),
    );
  }
}

// ─── Outline Button ──────────────────────────────────────────────────────────
class _OutlineButton extends StatelessWidget {
  const _OutlineButton({
    required this.label,
    required this.onPressed,
    required this.isLoading,
    required this.borderRadius,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: BorderSide(
          color: onPressed == null
              ? AppColors.primary.withValues(alpha: 0.5)
              : AppColors.primary,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: _ButtonContent(
        label: label,
        icon: icon,
        isLoading: isLoading,
        textStyle: AppTextStyles.buttonLarge,
        loaderColor: AppColors.primary,
      ),
    );
  }
}

// ─── Ghost Button ────────────────────────────────────────────────────────────
class _GhostButton extends StatelessWidget {
  const _GhostButton({
    required this.label,
    required this.onPressed,
    required this.isLoading,
    required this.borderRadius,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: _ButtonContent(
        label: label,
        icon: icon,
        isLoading: isLoading,
        textStyle: AppTextStyles.buttonLarge,
        loaderColor: AppColors.primary,
      ),
    );
  }
}

// ─── Danger Button ───────────────────────────────────────────────────────────
class _DangerButton extends StatelessWidget {
  const _DangerButton({
    required this.label,
    required this.onPressed,
    required this.isLoading,
    required this.borderRadius,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.error,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: _ButtonContent(
        label: label,
        icon: icon,
        isLoading: isLoading,
        textStyle: AppTextStyles.buttonLarge,
        loaderColor: AppColors.textOnPrimary,
      ),
    );
  }
}

// ─── Button Content ──────────────────────────────────────────────────────────
class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.label,
    required this.isLoading,
    required this.textStyle,
    required this.loaderColor,
    this.icon,
  });

  final String label;
  final bool isLoading;
  final TextStyle textStyle;
  final Color loaderColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(loaderColor),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppDimensions.iconSm),
          SizedBox(width: 2.w),
          Text(label, style: textStyle),
        ],
      );
    }

    return Text(label, style: textStyle);
  }
}

/// Small icon-only button used for actions like back, close, etc.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.size = AppDimensions.iconXxl,
    this.iconSize = AppDimensions.iconMd,
    this.borderRadius = AppDimensions.radiusMd,
    this.hasBorder = false,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final double iconSize;
  final double borderRadius;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(borderRadius),
          border: hasBorder
              ? Border.all(color: AppColors.border, width: 1)
              : null,
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor ?? AppColors.textPrimary,
        ),
      ),
    );
  }
}
