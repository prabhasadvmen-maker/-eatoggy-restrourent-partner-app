import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Premium gradient wallet balance card displaying available balance and withdrawal action.
class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({
    super.key,
    required this.availableBalance,
    required this.pendingSettlement,
    required this.bankAccount,
    required this.onWithdraw,
  });

  final String availableBalance;
  final String pendingSettlement;
  final String bankAccount;
  final VoidCallback onWithdraw;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Label + Bank Tag
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available Balance',
                style: AppTextStyles.captionWhite.copyWith(
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.account_balance, size: 12, color: Colors.white),
                    SizedBox(width: 1.w),
                    Text(
                      bankAccount,
                      style: AppTextStyles.captionWhite.copyWith(fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),

          // Balance Amount
          Text(
            availableBalance,
            style: AppTextStyles.titleWhite.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 2.h),

          // Bottom row: Pending settlement & Withdraw action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pending Settlement',
                    style: AppTextStyles.captionWhite.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  SizedBox(height: 0.2.h),
                  Text(
                    pendingSettlement,
                    style: AppTextStyles.captionWhite.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                  ),
                ),
                onPressed: onWithdraw,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_outward_rounded, size: 16),
                    SizedBox(width: 1.w),
                    Text(
                      'Withdraw',
                      style: AppTextStyles.captionMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
