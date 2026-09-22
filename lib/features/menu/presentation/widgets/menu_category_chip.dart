import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Category selection pill chip used in the Menu management screen.
class MenuCategoryChip extends StatelessWidget {
  const MenuCategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.count,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.9.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTextStyles.captionMedium.copyWith(
                color: isSelected ? AppColors.textOnPrimary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            if (count != null) ...[
              SizedBox(width: 1.5.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 0.1.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.25)
                      : AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                ),
                child: Text(
                  '$count',
                  style: AppTextStyles.caption.copyWith(
                    color: isSelected ? AppColors.textOnPrimary : AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
