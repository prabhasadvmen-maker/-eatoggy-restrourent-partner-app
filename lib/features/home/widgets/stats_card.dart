import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';

/// Stats summary card shown on the home dashboard.
class StatsCard extends StatelessWidget {
  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.subtitle,
    this.trendValue,
    this.isTrendUp,
    this.gradient,
    this.iconBackground,
  });

  final String title;
  final String value;
  final IconData icon;
  final String? subtitle;
  final String? trendValue;
  final bool? isTrendUp;
  final LinearGradient? gradient;
  final Color? iconBackground;

  @override
  Widget build(BuildContext context) {
    final isColored = gradient != null;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient == null ? AppColors.surface : null,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        border: gradient == null
            ? Border.all(color: AppColors.border, width: 1)
            : null,
        boxShadow: [
          BoxShadow(
            color: gradient != null
                ? AppColors.primary.withValues(alpha: 0.2)
                : AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Icon ─────────────────────────────────────────────────────
          Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: iconBackground ??
                  (isColored
                      ? AppColors.textOnPrimary.withValues(alpha: 0.2)
                      : AppColors.primaryLight.withValues(alpha: 0.1)),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            ),
            child: Icon(
              icon,
              size: 5.w,
              color: isColored
                  ? AppColors.textOnPrimary
                  : AppColors.primary,
            ),
          ),

          SizedBox(height: 2.h),

          // ─── Value ────────────────────────────────────────────────────
          Text(
            value,
            style: AppTextStyles.heading.copyWith(
              color: isColored ? AppColors.textOnPrimary : AppColors.textPrimary,
            ),
          ),

          SizedBox(height: 0.4.h),

          // ─── Title ────────────────────────────────────────────────────
          Text(
            title,
            style: AppTextStyles.caption.copyWith(
              color: isColored
                  ? AppColors.textOnPrimary.withValues(alpha: 0.8)
                  : AppColors.textSecondary,
            ),
          ),

          // ─── Trend ────────────────────────────────────────────────────
          if (trendValue != null && isTrendUp != null) ...[
            SizedBox(height: 0.8.h),
            Row(
              children: [
                Icon(
                  isTrendUp! ? Icons.trending_up : Icons.trending_down,
                  size: 14,
                  color: isTrendUp!
                      ? (isColored
                          ? AppColors.textOnPrimary
                          : AppColors.success)
                      : AppColors.error,
                ),
                SizedBox(width: 1.w),
                Text(
                  trendValue!,
                  style: AppTextStyles.captionMedium.copyWith(
                    color: isTrendUp!
                        ? (isColored
                            ? AppColors.textOnPrimary
                            : AppColors.success)
                        : AppColors.error,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
