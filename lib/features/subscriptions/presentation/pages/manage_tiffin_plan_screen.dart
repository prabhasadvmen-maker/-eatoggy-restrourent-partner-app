import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/manage_tiffin_plan_provider.dart';

class ManageTiffinPlanScreen extends ConsumerStatefulWidget {
  const ManageTiffinPlanScreen({
    super.key,
    required this.programId,
  });

  final String programId;

  @override
  ConsumerState<ManageTiffinPlanScreen> createState() =>
      _ManageTiffinPlanScreenState();
}

class _ManageTiffinPlanScreenState
    extends ConsumerState<ManageTiffinPlanScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(manageTiffinPlanProvider.notifier)
          .initializeForProgram(widget.programId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(manageTiffinPlanProvider);
    final notifier = ref.read(manageTiffinPlanProvider.notifier);
    final model = state.model;
    final subscribers = state.filteredSubscribers;

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
                          model.planTitle,
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
                padding: EdgeInsets.all(4.5.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF171715),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF262622), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.priceTitle,
                          style: AppTextStyles.headingWhite.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w900,
                            color: AppColors.creamText,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.5.w,
                            vertical: 0.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: state.isPaused
                                ? const Color(0xFF2B2215)
                                : const Color(0xFF142918),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            state.isPaused ? 'PAUSED' : 'ACTIVE',
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 10.5.sp,
                              fontWeight: FontWeight.w800,
                              color: state.isPaused
                                  ? const Color(0xFFFF9800)
                                  : const Color(0xFF4CAF50),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.5.h),
                    Row(
                      children: [
                        Text('🕒', style: TextStyle(fontSize: 12.sp)),
                        SizedBox(width: 1.5.w),
                        Text(
                          'Delivery window: ',
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 12.5.sp,
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                        Text(
                          model.deliveryWindow,
                          style: AppTextStyles.bodyWhite.copyWith(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.creamText,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.8.h),
                    Row(
                      children: [
                        Text('🍲', style: TextStyle(fontSize: 12.sp)),
                        SizedBox(width: 1.5.w),
                        Text(
                          'Meal setup: ',
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 12.5.sp,
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                        Text(
                          model.mealSetup,
                          style: AppTextStyles.bodyWhite.copyWith(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.creamText,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.5.h),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 5.2.h,
                            child: ElevatedButton(
                              onPressed: () {
                                notifier.togglePausePlan();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      state.isPaused
                                          ? 'Plan has been paused!'
                                          : 'Plan has been resumed!',
                                    ),
                                    backgroundColor: state.isPaused
                                        ? AppColors.warning
                                        : AppColors.success,
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1F1F1D),
                                elevation: 0,
                                minimumSize: Size.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: Color(0xFF2E2E2A),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Text(
                                state.isPaused ? 'Resume Plan' : 'Pause Plan',
                                style: AppTextStyles.buttonMedium.copyWith(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.creamText,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 3.5.w),
                        Expanded(
                          child: SizedBox(
                            height: 5.2.h,
                            child: ElevatedButton(
                              onPressed: () {
                                context.push(AppRoutes.createTiffinPlan);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1F1F1D),
                                elevation: 0,
                                minimumSize: Size.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: Color(0xFF2E2E2A),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Edit Details',
                                style: AppTextStyles.buttonMedium.copyWith(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subscribers (${model.subscribersCount})',
                    style: AppTextStyles.headingWhite.copyWith(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.creamText,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => notifier.toggleSearch(),
                    child: Icon(
                      Icons.search_rounded,
                      color: AppColors.primary,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
              if (state.isSearchActive) ...[
                SizedBox(height: 1.5.h),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF171715),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF262622),
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    onChanged: notifier.updateSearch,
                    style: AppTextStyles.body.copyWith(color: AppColors.creamText),
                    decoration: InputDecoration(
                      hintText: 'Search subscriber by name or phone...',
                      hintStyle: AppTextStyles.caption.copyWith(
                        color: const Color(0xFF555550),
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: AppColors.primary,
                        size: 16.sp,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.5.h,
                      ),
                    ),
                  ),
                ),
              ],
              SizedBox(height: 1.8.h),
              ...subscribers.map((sub) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 1.5.h),
                  padding: EdgeInsets.all(3.5.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF171715),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFF262622),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 11.w,
                        height: 11.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF242422),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            sub.avatarLetter,
                            style: AppTextStyles.titleMedium.copyWith(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
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
                              sub.name,
                              style: AppTextStyles.bodyWhite.copyWith(
                                fontSize: 14.5.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.creamText,
                              ),
                            ),
                            SizedBox(height: 0.4.h),
                            Text(
                              sub.phone,
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 12.sp,
                                color: AppColors.textSecondaryDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Ends in ${sub.endsInDays} days',
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 11.5.sp,
                              color: AppColors.textSecondaryDark,
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            sub.status,
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w800,
                              color: sub.isActive
                                  ? const Color(0xFF4CAF50)
                                  : const Color(0xFFFF9800),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }
}
