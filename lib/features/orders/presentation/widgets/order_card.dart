import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../widgets/app_badge.dart';

/// Order card shown in the orders list.
class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.orderId,
    required this.customerName,
    required this.customerPhone,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.time,
    this.onTap,
    this.onAccept,
    this.onReject,
    this.onMarkReady,
  });

  final String orderId;
  final String customerName;
  final String customerPhone;
  final List<String> items;
  final String totalAmount;
  final String status;
  final String time;
  final VoidCallback? onTap;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onMarkReady;

  bool get _isNew => status.toLowerCase() == 'new' || status.toLowerCase() == 'pending';
  bool get _isPreparing => status.toLowerCase() == 'preparing' || status.toLowerCase() == 'accepted' || status.toLowerCase() == 'active';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          border: Border.all(
            color: _isNew ? AppColors.orderNew.withValues(alpha: 0.3) : AppColors.border,
            width: _isNew ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Header ─────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(4.w, 3.w, 4.w, 2.w),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Order #$orderId',
                              style: AppTextStyles.bodyMedium,
                            ),
                            SizedBox(width: 2.w),
                            AppBadge.orderStatus(status),
                          ],
                        ),
                        SizedBox(height: 0.3.h),
                        Text(
                          '$customerName • $time',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    totalAmount,
                    style: AppTextStyles.subhead.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            Divider(height: 1, color: AppColors.divider),

            // ─── Items ──────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.w),
              child: Text(
                items.join(', '),
                style: AppTextStyles.caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // ─── Actions (for New/Active orders) ────────────────────────
            if (_isNew || _isPreparing) ...[
              Divider(height: 1, color: AppColors.divider),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 1.5.w,
                ),
                child: _buildActions(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    if (_isNew) {
      return Row(
        children: [
          Expanded(
            child: _ActionButton(
              label: 'Reject',
              textColor: AppColors.error,
              backgroundColor: AppColors.errorLight,
              onTap: onReject,
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            flex: 2,
            child: _ActionButton(
              label: 'Accept Order',
              textColor: AppColors.textOnPrimary,
              backgroundColor: AppColors.primary,
              onTap: onAccept,
            ),
          ),
        ],
      );
    } else if (_isPreparing) {
      return _ActionButton(
        label: 'Mark as Ready',
        textColor: AppColors.textOnPrimary,
        backgroundColor: AppColors.success,
        onTap: onMarkReady,
      );
    }

    return const SizedBox.shrink();
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.textColor,
    required this.backgroundColor,
    this.onTap,
  });

  final String label;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.2.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTextStyles.captionMedium.copyWith(color: textColor),
        ),
      ),
    );
  }
}
