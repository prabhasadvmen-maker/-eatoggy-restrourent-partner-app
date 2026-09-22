import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/helpers.dart';
import '../providers/application_submitted_provider.dart';

class ApplicationSubmittedScreen extends ConsumerWidget {
  const ApplicationSubmittedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(applicationSubmittedProvider);
    final data = state.data;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(60),
                      blurRadius: 30,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: const Color(0xFF11110F),
                  size: 32.sp,
                ),
              ),
              SizedBox(height: 3.5.h),
              Text(
                data.title,
                textAlign: TextAlign.center,
                style: AppTextStyles.headingWhite.copyWith(
                  fontSize: 19.5.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                data.subtitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySecondary.copyWith(
                  fontSize: 13.5.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 4.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.darkBorder, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.applicationIdLabel,
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 11.5.sp,
                        color: AppColors.textMuted,
                      ),
                    ),
                    SizedBox(height: 0.6.h),
                    Text(
                      data.applicationIdValue,
                      style: AppTextStyles.titleMedium.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Divider(color: AppColors.darkBorder, height: 1),
                    SizedBox(height: 2.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: AppColors.primary,
                          size: 18.sp,
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: AppTextStyles.bodySecondary.copyWith(
                                fontSize: 13.sp,
                                color: AppColors.textMuted,
                                height: 1.4,
                              ),
                              children: [
                                const TextSpan(
                                  text: "We'll verify your details and respond back within ",
                                ),
                                TextSpan(
                                  text: '24-48 hours',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const TextSpan(text: '.'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 3),
              SizedBox(
                width: double.infinity,
                height: 6.2.h,
                child: ElevatedButton(
                  onPressed: () => context.go(AppRoutes.dashboard),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF28251E),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: const BorderSide(
                        color: AppColors.darkBorder,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(
                    data.buttonText,
                    style: AppTextStyles.buttonLarge.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1.5.h),
              Text(
                data.accessibleNote,
                textAlign: TextAlign.center,
                style: AppTextStyles.caption.copyWith(
                  fontSize: 11.5.sp,
                  color: AppColors.textMuted,
                ),
              ),
              SizedBox(height: 2.5.h),
              GestureDetector(
                onTap: () => Helpers.makePhoneCall('18001234567'),
                child: RichText(
                  text: TextSpan(
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.textMuted,
                    ),
                    children: [
                      TextSpan(text: data.needHelpPrefix),
                      TextSpan(
                        text: data.contactSupportText,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
