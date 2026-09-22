import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import 'app_button.dart';

/// Error state widget displayed when something goes wrong.
class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    this.title = 'Something went wrong',
    this.subtitle = 'Please try again',
    this.onRetry,
  });

  final String title;
  final String? subtitle;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                color: AppColors.errorLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi_off_rounded,
                size: 9.w,
                color: AppColors.error,
              ),
            ),
            SizedBox(height: 2.4.h),
            Text(
              title,
              style: AppTextStyles.subhead,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              SizedBox(height: 0.8.h),
              Text(
                subtitle!,
                style: AppTextStyles.caption,
                textAlign: TextAlign.center,
              ),
            ],
            if (onRetry != null) ...[
              SizedBox(height: 3.h),
              AppButton(
                label: 'Try Again',
                onPressed: onRetry,
                width: 50.w,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
