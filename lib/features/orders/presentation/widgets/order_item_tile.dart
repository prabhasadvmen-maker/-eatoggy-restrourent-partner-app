import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Reusable order item line widget used in Order Details & summaries.
class OrderItemTile extends StatelessWidget {
  const OrderItemTile({
    super.key,
    required this.name,
    required this.quantity,
    required this.price,
    this.customization,
    this.isVeg = true,
  });

  final String name;
  final int quantity;
  final String price;
  final String? customization;
  final bool isVeg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Veg / Non-Veg badge icon
          Container(
            margin: EdgeInsets.only(top: 0.4.h),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              border: Border.all(
                color: isVeg ? AppColors.veg : AppColors.nonVeg,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(AppDimensions.radiusXs),
            ),
            child: Icon(
              Icons.circle,
              size: 8,
              color: isVeg ? AppColors.veg : AppColors.nonVeg,
            ),
          ),
          SizedBox(width: 2.5.w),

          // Quantity multiplier
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.3.h),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
            ),
            child: Text(
              '${quantity}x',
              style: AppTextStyles.captionMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 2.5.w),

          // Item name & customizations
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.bodyMedium,
                ),
                if (customization != null && customization!.isNotEmpty) ...[
                  SizedBox(height: 0.3.h),
                  Text(
                    customization!,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: 2.w),

          // Price
          Text(
            price,
            style: AppTextStyles.bodySemiBold,
          ),
        ],
      ),
    );
  }
}
