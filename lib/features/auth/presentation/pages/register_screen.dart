import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/register_provider.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  void _onStartRegistration(BuildContext context, WidgetRef ref) {
    ref.read(registerProvider.notifier).startRegistration(
      onSuccess: () {
        context.push(AppRoutes.businessProfile);
      },
      onError: (msg) {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerProvider);
    final data = registerState.data;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),

              Text.rich(
                TextSpan(
                  text: data.titlePrefix,
                  style: AppTextStyles.title.copyWith(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                  ),
                  children: [
                    TextSpan(
                      text: data.brandName,
                      style: AppTextStyles.title.copyWith(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.goldFont,
                      ),
                    ),
                    TextSpan(
                      text: '\n${data.titleSuffix.trim()}',
                      style: AppTextStyles.title.copyWith(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 1.2.h),

              Text(
                data.subtitle,
                style: AppTextStyles.bodySecondary
              ),

              SizedBox(height: 3.h),

              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: SizedBox(
                  width: double.infinity,
                  height: 24.h,
                  child: Image.asset(
                    data.heroImageAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.darkSurface,
                      child: Icon(
                        Icons.restaurant_rounded,
                        size: 40.sp,
                        color: AppColors.goldFont,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 3.h),

              ...data.features.map(
                (feature) => Padding(
                  padding: EdgeInsets.only(bottom: 2.2.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: BoxDecoration(
                          color: AppColors.darkSurface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.darkBorder.withValues(alpha: 0.6),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            feature.icon,
                            size: 16.sp,
                            color: AppColors.goldFont,
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              feature.title,
                              style: AppTextStyles.subheadMedium.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 0.4.h),
                            Text(
                              feature.subtitle,
                              style: AppTextStyles.bodySecondary.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 2.h),

              SizedBox(
                width: double.infinity,
                height: 6.2.h,
                child: ElevatedButton(
                  onPressed: registerState.isLoading
                      ? null
                      : () => _onStartRegistration(context, ref),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor:
                        AppColors.primary.withValues(alpha: 0.5),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: registerState.isLoading
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
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data.buttonText,
                              style: AppTextStyles.buttonLarge.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF11110F),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 20.sp,
                              color: const Color(0xFF11110F),
                            ),
                          ],
                        ),
                ),
              ),

              SizedBox(height: 2.5.h),

              Center(
                child: GestureDetector(
                  onTap: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(AppRoutes.login);
                    }
                  },
                  child: Text.rich(
                    TextSpan(
                      text: '${data.loginPrefix} ',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 15.sp,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: data.loginAction,
                          style: AppTextStyles.captionPrimary.copyWith(
                            fontSize: 15.sp,
                            color: AppColors.goldFont,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }
}
