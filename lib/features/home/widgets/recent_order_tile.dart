import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../widgets/app_badge.dart';

/// Recent order list tile shown on the home screen.
class RecentOrderTile extends StatelessWidget {
  const RecentOrderTile({
    super.key,
    required this.orderId,
    required this.customerName,
    required this.amount,
    required this.itemCount,
    required this.status,
    required this.time,
    this.onTap,
  });

  final String orderId;
  final String customerName;
  final String amount;
  final int itemCount;
  final String status;
  final String time;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Row(
          children: [
            // ─── Order Icon ─────────────────────────────────────────────
            Container(
              width: 11.w,
              height: 11.w,
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              ),
              child: Icon(
                Icons.receipt_long_outlined,
                size: 5.5.w,
                color: AppColors.primary,
              ),
            ),

            SizedBox(width: 3.w),

            // ─── Order Info ──────────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '#$orderId',
                        style: AppTextStyles.bodyMedium,
                      ),
                      Text(
                        amount,
                        style: AppTextStyles.bodySemiBold.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$customerName • $itemCount ${itemCount == 1 ? 'item' : 'items'}',
                        style: AppTextStyles.caption,
                      ),
                      Text(
                        time,
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                  SizedBox(height: 0.8.h),
                  AppBadge.orderStatus(status),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
