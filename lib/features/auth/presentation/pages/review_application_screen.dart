import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/review_application_provider.dart';

class ReviewApplicationScreen extends ConsumerStatefulWidget {
  const ReviewApplicationScreen({super.key});

  @override
  ConsumerState<ReviewApplicationScreen> createState() =>
      _ReviewApplicationScreenState();
}

class _ReviewApplicationScreenState
    extends ConsumerState<ReviewApplicationScreen> {
  void _onSubmit() {
    ref.read(reviewApplicationProvider.notifier).submitApplication(
      onSuccess: () {
        if (!mounted) return;
        context.push(AppRoutes.applicationSubmitted);
      },
      onError: (msg) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg, style: AppTextStyles.captionWhite),
            backgroundColor: AppColors.error,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reviewApplicationProvider);
    final data = state.data;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 1.5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.chevron_left,
                          color: AppColors.goldFont,
                          size: 20.sp,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          data.screenTitle,
                          style: AppTextStyles.titleMedium.copyWith(
                            fontSize: 15.5.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    data.stepText,
                    style: AppTextStyles.captionMedium.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                height: 3,
                width: double.infinity,
                color: AppColors.primary,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 3.h),
                    Text(
                      data.headingText,
                      style: AppTextStyles.headingWhite.copyWith(
                        fontSize: 17.5.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 2.5.h),
                    _buildBusinessCard(context, data),
                    SizedBox(height: 2.h),
                    _buildDocumentsCard(context, data),
                    SizedBox(height: 2.h),
                    _buildBankCard(context, data),
                    SizedBox(height: 2.h),
                    _buildFeeCard(context, data),
                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 3.h),
              child: SizedBox(
                width: double.infinity,
                height: 6.2.h,
                child: ElevatedButton(
                  onPressed: state.isLoading ? null : _onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: state.isLoading
                      ? SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              const Color(0xFF11110F),
                            ),
                          ),
                        )
                      : Text(
                          data.buttonText,
                          style: AppTextStyles.buttonLarge.copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF11110F),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessCard(BuildContext context, dynamic data) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.businessTitle,
                style: AppTextStyles.subhead.copyWith(
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              GestureDetector(
                onTap: () => context.pop(),
                child: Icon(
                  Icons.edit_square,
                  color: AppColors.primary,
                  size: 16.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.2.h),
          Text(
            data.restaurantName,
            style: AppTextStyles.bodyWhite.copyWith(
              fontSize: 15.5.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            data.businessSubtext,
            style: AppTextStyles.caption.copyWith(
              fontSize: 12.5.sp,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsCard(BuildContext context, dynamic data) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.documentsTitle,
            style: AppTextStyles.subhead.copyWith(
              fontSize: 14.5.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 1.5.h),
          ...((data.documentsList as List<String>).map(
            (doc) => Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.success,
                    size: 16.sp,
                  ),
                  SizedBox(width: 2.5.w),
                  Text(
                    doc,
                    style: AppTextStyles.bodySecondary.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildBankCard(BuildContext context, dynamic data) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.bankTitle,
                style: AppTextStyles.subhead.copyWith(
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              GestureDetector(
                onTap: () => context.pop(),
                child: Icon(
                  Icons.edit_square,
                  color: AppColors.primary,
                  size: 16.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.2.h),
          Text(
            data.bankInfo,
            style: AppTextStyles.bodySecondary.copyWith(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeCard(BuildContext context, dynamic data) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.feeTitle,
                  style: AppTextStyles.subhead.copyWith(
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  data.feeSubtext,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Text(
            data.feeAmount,
            style: AppTextStyles.headingWhite.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
