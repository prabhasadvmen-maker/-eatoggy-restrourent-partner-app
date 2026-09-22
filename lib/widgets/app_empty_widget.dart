import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import 'app_button.dart';

/// Empty state widget displayed when a list or page has no content.
class AppEmptyWidget extends StatelessWidget {
  const AppEmptyWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.message,
    this.icon,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? subtitle;
  final String? message;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  String? get _displaySubtitle => subtitle ?? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ─── Icon ───────────────────────────────────────────────────
            Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon ?? Icons.inbox_outlined,
                size: 9.w,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 2.4.h),

            // ─── Title ──────────────────────────────────────────────────
            Text(
              title,
              style: AppTextStyles.subhead,
              textAlign: TextAlign.center,
            ),

            // ─── Subtitle ───────────────────────────────────────────────
            if (_displaySubtitle != null) ...[
              SizedBox(height: 0.8.h),
              Text(
                _displaySubtitle!,
                style: AppTextStyles.caption,
                textAlign: TextAlign.center,
              ),
            ],

            // ─── Action ─────────────────────────────────────────────────
            if (actionLabel != null && onAction != null) ...[
              SizedBox(height: 3.h),
              AppButton(
                label: actionLabel!,
                onPressed: onAction,
                width: 50.w,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
