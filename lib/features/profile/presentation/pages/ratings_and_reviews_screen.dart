import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/ratings_and_reviews_model.dart';
import '../providers/ratings_and_reviews_provider.dart';

class RatingsAndReviewsScreen extends ConsumerWidget {
  const RatingsAndReviewsScreen({super.key, this.initialData});

  final RatingsAndReviewsModel? initialData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ratingsAndReviewsProvider);
    final notifier = ref.read(ratingsAndReviewsProvider.notifier);
    final model = initialData ?? state.model;
    final selectedFilter = state.selectedFilter;

    final fullStars = int.tryParse(model.overallRating.split('.').first) ?? 4;

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
                          size: 16.sp,
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
                          'Ratings and Reviews',
                          style: AppTextStyles.headingWhite.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.creamText,
                          ),
                        ),
                        SizedBox(height: 0.3.h),
                        Text(
                          'Feedback & Satisfaction',
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
              GestureDetector(
                onTap: () => context.push(AppRoutes.customerReviews),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF262622), width: 1),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'OVERALL CUSTOMER RATING',
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondaryDark,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            model.overallRating,
                            style: AppTextStyles.headingWhite.copyWith(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(width: 3.5.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: List.generate(5, (index) {
                                  if (index < fullStars) {
                                    return Icon(
                                      Icons.star_rounded,
                                      color: AppColors.primary,
                                      size: 16.sp,
                                    );
                                  }
                                  return Icon(
                                    Icons.star_outline_rounded,
                                    color: const Color(0xFF55554E),
                                    size: 16.sp,
                                  );
                                }),
                              ),
                              SizedBox(height: 0.3.h),
                              Text(
                                'out of 5 stars',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondaryDark,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 1.8.h),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Based on ',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondaryDark,
                              ),
                            ),
                            TextSpan(
                              text: '${model.verifiedReviewsCount}',
                              style: AppTextStyles.caption.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                            TextSpan(
                              text: ' verified reviews',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondaryDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 2.5.h),
              Text(
                'Rating Distribution',
                style: AppTextStyles.headingWhite.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.creamText,
                ),
              ),
              SizedBox(height: 1.5.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.2.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF171715),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF262622), width: 1),
                ),
                child: Column(
                  children: model.distributions.map((item) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.8.h),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 14.w,
                            child: Text(
                              item.starsLabel,
                              style: AppTextStyles.body.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.creamText,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 7,
                              decoration: BoxDecoration(
                                color: const Color(0xFF242420),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: item.fillRatio,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          SizedBox(
                            width: 10.w,
                            child: Text(
                              '${item.percentage}%',
                              textAlign: TextAlign.end,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondaryDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 2.2.h),
              Row(
                children: model.filterChips.map((chip) {
                  final isSelected = selectedFilter == chip;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      child: GestureDetector(
                        onTap: () => notifier.setFilter(chip),
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
                              chip,
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
              Text(
                'This Month Performance',
                style: AppTextStyles.headingWhite.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.creamText,
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(3.5.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF171715),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF262622),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AVERAGE',
                            style: AppTextStyles.caption.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textSecondaryDark,
                            ),
                          ),
                          SizedBox(height: 0.8.h),
                          Text(
                            model.monthlyPerformance.averageRating,
                            style: AppTextStyles.headingWhite.copyWith(
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF4CAF50),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 2.5.w),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(3.5.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF171715),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF262622),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TOTAL REVIEWS',
                            style: AppTextStyles.caption.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textSecondaryDark,
                            ),
                          ),
                          SizedBox(height: 0.8.h),
                          Text(
                            '${model.monthlyPerformance.totalReviews}',
                            style: AppTextStyles.headingWhite.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.creamText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 2.5.w),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(3.5.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF171715),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF262622),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'RESPONSE RATE',
                            style: AppTextStyles.caption.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textSecondaryDark,
                            ),
                          ),
                          SizedBox(height: 0.8.h),
                          Text(
                            model.monthlyPerformance.responseRate,
                            style: AppTextStyles.headingWhite.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.5.h),
            ],
          ),
        ),
      ),
    );
  }
}
