import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Card representing a menu item with in-stock toggle switch and edit button.
class MenuItemCard extends StatelessWidget {
  const MenuItemCard({
    super.key,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.isAvailable,
    required this.isVeg,
    required this.onToggleAvailability,
    this.onEdit,
  });

  final String name;
  final String category;
  final String price;
  final String description;
  final bool isAvailable;
  final bool isVeg;
  final ValueChanged<bool> onToggleAvailability;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(3.5.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Veg / Non-veg marker + Food Image placeholder
                Stack(
                  children: [
                    Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.surfaceVariant,
                            AppColors.primaryLight.withValues(alpha: 0.3),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.restaurant_menu_rounded,
                          color: AppColors.primary.withValues(alpha: 0.6),
                          size: AppDimensions.iconLg,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          border: Border.all(
                            color: isVeg ? AppColors.veg : AppColors.nonVeg,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(AppDimensions.radiusXs),
                        ),
                        child: Icon(
                          Icons.circle,
                          size: 7,
                          color: isVeg ? AppColors.veg : AppColors.nonVeg,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 3.w),

                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: AppTextStyles.bodySemiBold,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (onEdit != null)
                            GestureDetector(
                              onTap: onEdit,
                              child: Padding(
                                padding: EdgeInsets.only(left: 2.w),
                                child: Icon(
                                  Icons.edit_outlined,
                                  size: 18,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 0.3.h),
                      Text(
                        category,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 0.4.h),
                      Text(
                        description,
                        style: AppTextStyles.caption,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0.6.h),
                      Text(
                        price,
                        style: AppTextStyles.subhead.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1, color: AppColors.divider),

          // In-Stock availability row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      isAvailable ? Icons.check_circle : Icons.do_not_disturb_on,
                      size: 16,
                      color: isAvailable ? AppColors.success : AppColors.error,
                    ),
                    SizedBox(width: 1.5.w),
                    Text(
                      isAvailable ? 'In Stock (Accepting Orders)' : 'Out of Stock',
                      style: AppTextStyles.captionMedium.copyWith(
                        color: isAvailable ? AppColors.success : AppColors.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: isAvailable,
                    onChanged: onToggleAvailability,
                    activeThumbColor: AppColors.primary,
                    activeTrackColor: AppColors.primaryLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
