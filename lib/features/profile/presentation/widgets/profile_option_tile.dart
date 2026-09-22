import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Reusable profile settings row option with icon, title, subtitle, and trailing action.
class ProfileOptionTile extends StatelessWidget {
  const ProfileOptionTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.isDestructive = false,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool isDestructive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.textPrimary;
    final iconColor = isDestructive ? AppColors.error : AppColors.primary;
    final iconBgColor =
        isDestructive ? AppColors.errorLight : AppColors.primaryLight;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.4.h),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            SizedBox(width: 3.5.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: color,
                      fontWeight: isDestructive ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 0.2.h),
                    Text(
                      subtitle!,
                      style: AppTextStyles.caption,
                    ),
                  ],
                ],
              ),
            ),
            trailing ??
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
          ],
        ),
      ),
    );
  }
}
