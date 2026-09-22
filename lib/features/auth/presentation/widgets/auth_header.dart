import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Reusable header widget for authentication screens.
class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─── Logo ─────────────────────────────────────────────────────────
        Row(
          children: [
            Container(
              width: 11.w,
              height: 11.w,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.restaurant_menu,
                size: 6.w,
                color: AppColors.textOnPrimary,
              ),
            ),
            SizedBox(width: 3.w),
            Text(
              'Eatoggy',
              style: AppTextStyles.heading.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),

        SizedBox(height: 4.h),

        // ─── Title ────────────────────────────────────────────────────────
        Text(title, style: AppTextStyles.title),

        SizedBox(height: 0.8.h),

        // ─── Subtitle ─────────────────────────────────────────────────────
        Text(subtitle, style: AppTextStyles.bodySecondary),
      ],
    );
  }
}
