import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_dimensions.dart';
import '../core/theme/app_text_styles.dart';

/// Reusable styled text field.
/// Supports: label, hint, prefix/suffix icons, password toggle, error state, read-only.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.keyboardType,
    this.textInputAction,
    this.isPassword = false,
    this.isReadOnly = false,
    this.isEnabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.validator,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.none,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isPassword;
  final bool isReadOnly;
  final bool isEnabled;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ─── Label ──────────────────────────────────────────────────────
        if (widget.label != null) ...[
          Text(widget.label!, style: AppTextStyles.label),
          SizedBox(height: 0.8.h),
        ],

        // ─── Text Input ─────────────────────────────────────────────────
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: widget.isPassword ? _obscureText : false,
          readOnly: widget.isReadOnly,
          enabled: widget.isEnabled,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          onTap: widget.onTap,
          validator: widget.validator,
          autofillHints: widget.autofillHints,
          textCapitalization: widget.textCapitalization,
          style: AppTextStyles.bodySecondary,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.hint,
            errorText: widget.errorText,
            errorStyle: AppTextStyles.captionError,
            helperText: widget.helperText,
            helperStyle: AppTextStyles.caption,
            counterText: '',
            filled: true,
            fillColor: widget.isEnabled
                ? AppColors.surface
                : AppColors.surfaceVariant,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 1.6.h,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    size: AppDimensions.iconMd,
                    color: AppColors.textSecondary,
                  )
                : null,
            suffixIcon: _buildSuffixIcon(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              borderSide: const BorderSide(color: AppColors.border, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              borderSide: const BorderSide(color: AppColors.border, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              borderSide: const BorderSide(
                color: AppColors.borderFocused,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              borderSide: const BorderSide(color: AppColors.error, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              borderSide: const BorderSide(color: AppColors.error, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              borderSide: const BorderSide(color: AppColors.border, width: 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.isPassword) {
      return GestureDetector(
        onTap: () => setState(() => _obscureText = !_obscureText),
        child: Icon(
          _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          size: AppDimensions.iconMd,
          color: AppColors.textSecondary,
        ),
      );
    }

    if (widget.suffixIcon != null) {
      return GestureDetector(
        onTap: widget.onSuffixIconTap,
        child: Icon(
          widget.suffixIcon,
          size: AppDimensions.iconMd,
          color: AppColors.textSecondary,
        ),
      );
    }

    return null;
  }
}
