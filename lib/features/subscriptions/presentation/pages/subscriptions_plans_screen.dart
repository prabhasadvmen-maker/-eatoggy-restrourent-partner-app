import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/subscriptions_plans_provider.dart';

class SubscriptionsPlansScreen extends ConsumerWidget {
  const SubscriptionsPlansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(subscriptionsPlansProvider);
    final model = state.model;

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
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.primary,
                          size: 15.sp,
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
                          model.title,
                          style: AppTextStyles.headingWhite.copyWith(
                            fontSize: 17.5.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.creamText,
                          ),
                        ),
                        SizedBox(height: 0.3.h),
                        Text(
                          model.subtitle,
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.5.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(5.w),
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
                      model.monthlyEarningsTitle,
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondaryDark,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          model.monthlyEarningsAmount,
                          style: AppTextStyles.headingWhite.copyWith(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w900,
                            color: AppColors.creamText,
                          ),
                        ),
                        Text(
                          model.activeUsersText,
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF388E3C),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                model.programsSectionTitle,
                style: AppTextStyles.bodyWhite.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.creamText,
                ),
              ),
              SizedBox(height: 1.8.h),
              ...model.programs.map(
                (prog) => Padding(
                  padding: EdgeInsets.only(bottom: 1.8.h),
                  child: Container(
                    padding: EdgeInsets.all(4.5.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF171715),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(0xFF262622),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                prog.title,
                                style: AppTextStyles.bodyWhite.copyWith(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.creamText,
                                ),
                              ),
                            ),
                            Text(
                              prog.price,
                              style: AppTextStyles.bodyWhite.copyWith(
                                fontSize: 14.5.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 0.8.h),
                        Text(
                          prog.mealDetails,
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 12.5.sp,
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '👥 ',
                                  style: TextStyle(fontSize: 13.sp),
                                ),
                                Text(
                                  '${prog.activeSubscribersCount} ',
                                  style: AppTextStyles.bodyWhite.copyWith(
                                    fontSize: 13.5.sp,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.creamText,
                                  ),
                                ),
                                Text(
                                  'Active Subscribers',
                                  style: AppTextStyles.caption.copyWith(
                                    fontSize: 12.5.sp,
                                    color: AppColors.textSecondaryDark,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.5.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  context.push(
                                    AppRoutes.manageTiffinPlan,
                                    extra: prog.id,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  elevation: 0,
                                  minimumSize: Size.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                  ),
                                ),
                                child: Text(
                                  'Manage',
                                  style: AppTextStyles.buttonMedium.copyWith(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF11110F),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1.5.h),
              Text(
                model.dispatchSectionTitle,
                style: AppTextStyles.bodyWhite.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.creamText,
                ),
              ),
              SizedBox(height: 1.8.h),
              Row(
                children: model.dispatchLoads.map((load) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.push(AppRoutes.tiffinDeliveries);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          right: load == model.dispatchLoads.first ? 2.5.w : 0,
                          left: load == model.dispatchLoads.last ? 2.5.w : 0,
                        ),
                        padding: EdgeInsets.all(4.w),
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
                              load.header,
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 10.5.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textSecondaryDark,
                                letterSpacing: 0.8,
                              ),
                            ),
                            SizedBox(height: 0.8.h),
                            Text(
                              load.countText,
                              style: AppTextStyles.bodyWhite.copyWith(
                                fontSize: 16.5.sp,
                                fontWeight: FontWeight.w900,
                                color: AppColors.creamText,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              load.subtitle,
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 11.sp,
                                color: AppColors.textSecondaryDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            
              SizedBox(height: 3.5.h),
              SizedBox(
                width: double.infinity,
                height: 6.h,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.push(AppRoutes.createTiffinPlan);
                  },
                  icon: Icon(
                    Icons.add_rounded,
                    color: const Color(0xFF11110F),
                    size: 18.sp,
                  ),
                  label: Text(
                    'Create Tiffin Plan',
                    style: AppTextStyles.buttonMedium.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF11110F),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }
}
