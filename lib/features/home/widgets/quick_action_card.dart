import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';

/// Quick action button card used on the home screen.
class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
    this.backgroundColor,
    this.badge,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  final Color? backgroundColor;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3.5.w),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ─── Icon with optional badge ────────────────────────────────
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: (color ?? AppColors.primary).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                  ),
                  child: Icon(
                    icon,
                    size: 6.w,
                    color: color ?? AppColors.primary,
                  ),
                ),
                if (badge != null)
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        badge!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: 1.2.h),

            // ─── Label ──────────────────────────────────────────────────
            Text(
              label,
              style: AppTextStyles.captionMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
