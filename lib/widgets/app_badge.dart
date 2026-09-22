import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

/// Order/status badge widget.
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.color,
    this.backgroundColor,
  });

  final String label;
  final Color? color;
  final Color? backgroundColor;

  /// Factory for order status badge.
  factory AppBadge.orderStatus(String status) {
    Color color;
    Color bg;

    switch (status.toLowerCase()) {
      case 'new':
      case 'pending':
        color = AppColors.orderNew;
        bg = AppColors.orderNewLight;
        break;
      case 'accepted':
      case 'preparing':
      case 'active':
        color = AppColors.orderActive;
        bg = AppColors.orderActiveLight;
        break;
      case 'delivered':
      case 'completed':
        color = AppColors.orderDelivered;
        bg = AppColors.orderDeliveredLight;
        break;
      case 'cancelled':
      case 'rejected':
        color = AppColors.orderCancelled;
        bg = AppColors.orderCancelledLight;
        break;
      default:
        color = AppColors.textSecondary;
        bg = AppColors.surfaceVariant;
    }

    return AppBadge(label: status, color: color, backgroundColor: bg);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.4.h),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primaryLight.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: AppTextStyles.captionMedium
      ),
    );
  }
}
