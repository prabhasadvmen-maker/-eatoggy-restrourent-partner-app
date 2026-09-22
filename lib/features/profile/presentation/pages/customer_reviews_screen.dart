import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/customer_reviews_model.dart';
import '../providers/customer_reviews_provider.dart';

class CustomerReviewsScreen extends ConsumerStatefulWidget {
  const CustomerReviewsScreen({
    super.key,
    this.initialModel,
  });

  final CustomerReviewsListModel? initialModel;

  @override
  ConsumerState<CustomerReviewsScreen> createState() =>
      _CustomerReviewsScreenState();
}

class _CustomerReviewsScreenState extends ConsumerState<CustomerReviewsScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.initialModel != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(customerReviewsProvider.notifier)
            .initializeWithModel(widget.initialModel!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customerReviewsProvider);
    final reviews = state.model.reviews;

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
                          'Customer Reviews',
                          style: AppTextStyles.headingWhite.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.creamText,
                          ),
                        ),
                        SizedBox(height: 0.3.h),
                        Text(
                          'Recent testimonials & replies',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.5.h),
              ...reviews.map((item) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 1.8.h),
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF171715),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: item.isCritical
                          ? const Color(0xFF4A1F1F)
                          : const Color(0xFF262622),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            item.name,
                            style: AppTextStyles.headingWhite.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.creamText,
                            ),
                          ),
                          if (item.isCritical) ...[
                            SizedBox(width: 2.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                                vertical: 0.3.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF381A1A),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: const Color(0xFF5A2424),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'Critical',
                                style: AppTextStyles.caption.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFE57373),
                                ),
                              ),
                            ),
                          ],
                          const Spacer(),
                          Text(
                            item.timeAgo,
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 13.sp,
                              color: AppColors.textSecondaryDark,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.8.h),
                      Row(
                        children: List.generate(5, (index) {
                          if (index < item.rating) {
                            return Icon(
                              Icons.star_rounded,
                              color: AppColors.primary,
                              size: 16.sp,
                            );
                          }
                          return Icon(
                            Icons.star_outline_rounded,
                            color: const Color(0xFF44443F),
                            size: 16.sp,
                          );
                        }),
                      ),
                      SizedBox(height: 1.2.h),
                      Text(
                        item.comment,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.creamText,
                          height: 1.4,
                        ),
                      ),
                      if (item.partnerReply != null) ...[
                        SizedBox(height: 1.2.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(3.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1F1D17),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF332E22),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Reply',
                                style: AppTextStyles.caption.copyWith(
                                  // fontSize: 10.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                ),
                              ),
                              SizedBox(height: 0.3.h),
                              Text(
                                item.partnerReply!,
                                style: AppTextStyles.body.copyWith(
                                  // fontSize: 11.5.sp,
                                  color: AppColors.creamText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (item.orderedItem != null || item.canReply) ...[
                        SizedBox(height: 1.4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (item.orderedItem != null)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 2.5.w,
                                  vertical: 0.6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF211D15),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFF3B301D),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  item.orderedItem!,
                                  style: AppTextStyles.caption.copyWith(
                                    fontSize: 13.sp,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            else
                              const SizedBox.shrink(),
                            if (item.canReply)
                              GestureDetector(
                                onTap: () => context.push(
                                  AppRoutes.respondToReview,
                                  extra: item,
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                    vertical: 0.8.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Reply',
                                    style: AppTextStyles.buttonMedium.copyWith(
                                      color:  AppColors.background,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ],
                  ),
                );
              }),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }
}
