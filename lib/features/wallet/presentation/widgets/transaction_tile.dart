import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

enum TransactionType { payout, withdrawal, deduction, refund }

/// List tile representing a single wallet transaction (order credit, withdrawal, commission).
class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isCredit,
    required this.date,
    required this.status,
    this.type = TransactionType.payout,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final String amount;
  final bool isCredit;
  final String date;
  final String status;
  final TransactionType type;
  final VoidCallback? onTap;

  IconData get _icon {
    switch (type) {
      case TransactionType.payout:
        return Icons.arrow_downward_rounded;
      case TransactionType.withdrawal:
        return Icons.account_balance_outlined;
      case TransactionType.deduction:
        return Icons.percent_rounded;
      case TransactionType.refund:
        return Icons.replay_rounded;
    }
  }

  Color get _iconColor {
    switch (type) {
      case TransactionType.payout:
        return AppColors.success;
      case TransactionType.withdrawal:
        return AppColors.info;
      case TransactionType.deduction:
        return AppColors.warning;
      case TransactionType.refund:
        return AppColors.error;
    }
  }

  Color get _iconBgColor {
    switch (type) {
      case TransactionType.payout:
        return AppColors.successLight;
      case TransactionType.withdrawal:
        return AppColors.infoLight;
      case TransactionType.deduction:
        return AppColors.warningLight;
      case TransactionType.refund:
        return AppColors.errorLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.5.h),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _iconBgColor,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              ),
              child: Icon(_icon, color: _iconColor, size: 18),
            ),
            SizedBox(width: 3.w),

            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.3.h),
                  Text(
                    '$date • $subtitle',
                    style: AppTextStyles.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 2.w),

            // Amount & Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${isCredit ? "+" : "-"}$amount',
                  style: AppTextStyles.bodySemiBold.copyWith(
                    color: isCredit ? AppColors.success : AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 0.3.h),
                Text(
                  status,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 14.sp,
                    color: status.toLowerCase() == 'completed' || status.toLowerCase() == 'settled'
                        ? AppColors.success
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
