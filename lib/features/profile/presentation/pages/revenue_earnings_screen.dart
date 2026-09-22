import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/revenue_earnings_provider.dart';

class RevenueEarningsScreen extends ConsumerWidget {
  const RevenueEarningsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(revenueEarningsProvider);
    final notifier = ref.read(revenueEarningsProvider.notifier);
    final model = state.model;
    final earnings = state.activeEarnings;
    final selectedPeriod = state.selectedPeriod;

    const periods = ['Today', 'This Week', 'This Month', 'Custom'];

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.5.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF171715),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFF262622),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.primary,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.5.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Revenue & Earnings',
                          style: AppTextStyles.headingWhite.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.creamText,
                          ),
                        ),
                        SizedBox(height: 0.3.h),
                        Text(
                          'Finances and payouts tracker',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.2.h),
              Row(
                children: periods.map((period) {
                  final isSelected = selectedPeriod == period;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      child: GestureDetector(
                        onTap: () {
                          if (period == 'Custom') {
                            notifier.selectCustomDateRange(context);
                          } else {
                            notifier.selectPeriod(period);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 1.1.h),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : const Color(0xFF171715),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : const Color(0xFF282824),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              period,
                              style: AppTextStyles.caption.copyWith(
                                fontWeight: isSelected
                                    ? FontWeight.w800
                                    : FontWeight.w600,
                                color: isSelected
                                    ? const Color(0xFF11110F)
                                    : AppColors.creamText,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 2.5.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(4.5.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF171715),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF262622),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOTAL EARNINGS (${earnings.periodLabel})',
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondaryDark,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      earnings.totalEarnings,
                      style: AppTextStyles.headingWhite.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.creamText,
                      ),
                    ),
                    SizedBox(height: 0.8.h),
                    Row(
                      children: [
                        Icon(
                          Icons.trending_up_rounded,
                          color: const Color(0xFF4CAF50),
                          size: 18.sp,
                        ),
                        SizedBox(width: 1.5.w),
                        Text(
                          earnings.trendText,
                          style: AppTextStyles.caption.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF4CAF50),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),
              Text(
                'Earnings Breakdown',
                style: AppTextStyles.headingWhite.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.creamText,
                ),
              ),
              SizedBox(height: 1.5.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF171715),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF262622),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _buildBreakdownRow(
                      title: 'Food Orders',
                      subtitle: earnings.foodOrdersCount,
                      amount: earnings.foodOrdersAmount,
                    ),
                    const Divider(
                      height: 1,
                      color: Color(0xFF242420),
                      indent: 8,
                      endIndent: 8,
                    ),
                    _buildBreakdownRow(
                      title: 'Subscription/Tiffin',
                      subtitle: earnings.subscriptionsCount,
                      amount: earnings.subscriptionsAmount,
                    ),
                    const Divider(
                      height: 1,
                      color: Color(0xFF242420),
                      indent: 8,
                      endIndent: 8,
                    ),
                    _buildBreakdownRow(
                      title: 'Packaging Charges',
                      subtitle: earnings.packagingRate,
                      amount: earnings.packagingAmount,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),
              Text(
                'Last 7 Days Trend',
                style: AppTextStyles.headingWhite.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.creamText,
                ),
              ),
              SizedBox(height: 1.5.h),
              Container(
                width: double.infinity,
                height: 18.h,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF171715),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF262622),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: model.weeklyTrend.map((trend) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: FractionallySizedBox(
                                heightFactor: trend.heightFactor,
                                child: Container(
                                  width: 4.w,
                                  decoration: BoxDecoration(
                                    color: trend.isHighlighted
                                        ? AppColors.primary
                                        : const Color(0xFF2E2E28),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 1.2.h),
                          Text(
                            trend.dayLabel,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondaryDark,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 2.5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transactions',
                    style: AppTextStyles.headingWhite.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.creamText,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push(AppRoutes.transactions),
                    child: Text(
                      'View All',
                      style: AppTextStyles.captionPrimary.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.5.h),
              ...model.transactions.map((tx) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 1.2.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 1.8.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF171715),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF262622),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tx.code,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.creamText,
                            ),
                          ),
                          SizedBox(height: 0.3.h),
                          Text(
                            '${tx.type} • ${tx.timeAgo}',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondaryDark,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        tx.amount,
                        style: AppTextStyles.headingWhite.copyWith(
                          fontWeight: FontWeight.w800,
                          color: tx.isCredit
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFFE57373),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 3.5.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBreakdownRow({
    required String title,
    required String subtitle,
    required String amount,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.creamText,
                ),
              ),
              SizedBox(height: 0.3.h),
              Text(
                subtitle,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondaryDark,
                ),
              ),
            ],
          ),
          Text(
            amount,
            style: AppTextStyles.headingWhite.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
