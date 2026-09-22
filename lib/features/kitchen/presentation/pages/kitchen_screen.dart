import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/kitchen_provider.dart';

class KitchenScreen extends ConsumerWidget {
  const KitchenScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(kitchenProvider);
    final notifier = ref.read(kitchenProvider.notifier);
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 7.w,
                        height: 7.w,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 2.5.w),
                      Text(
                        model.appName,
                        style: AppTextStyles.titleMedium.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        state.isOnline ? 'ONLINE' : 'OFFLINE',
                        style: AppTextStyles.captionMedium.copyWith(
                          fontWeight: FontWeight.w800,
                          color: state.isOnline
                              ? AppColors.success
                              : AppColors.textMuted,
                        ),
                      ),
                      SizedBox(width: 1.5.w),
                      Transform.scale(
                        scale: 0.85,
                        child: Switch(
                          value: state.isOnline,
                          onChanged: notifier.toggleOnline,
                          activeTrackColor: AppColors.success,
                          activeThumbColor: Colors.white,
                          inactiveTrackColor: AppColors.darkBorder,
                          inactiveThumbColor: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 2.5.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 3.5.h, horizontal: 5.w),
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
                    Container(
                      width: 15.w,
                      height: 15.w,
                      decoration: BoxDecoration(
                        color: state.isOnline
                            ? const Color(0xFF162E1D)
                            : const Color(0xFF2E1C1C),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 5.5.w,
                          height: 5.5.w,
                          decoration: BoxDecoration(
                            color: state.isOnline
                                ? const Color(0xFF2ECC71)
                                : AppColors.error,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      state.isOnline
                          ? model.onlineStatusTitle
                          : 'Kitchen is Currently Offline',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headingWhite.copyWith(
                        fontSize: 17.5.sp,
                        fontWeight: FontWeight.w900,
                        color: AppColors.creamText,
                      ),
                    ),
                    SizedBox(height: 0.6.h),
                    Text(
                      model.onlineStatusSubtitle,
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 12.5.sp,
                        color: AppColors.textSecondaryDark,
                      ),
                    ),
                    SizedBox(height: 2.5.h),
                    Divider(color: const Color(0xFF262622), height: 1),
                    SizedBox(height: 2.5.h),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'TOTAL HOURS',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textSecondaryDark,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              SizedBox(height: 0.8.h),
                              Text(
                                model.totalHours,
                                style: AppTextStyles.bodyWhite.copyWith(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.creamText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 5.h,
                          color: const Color(0xFF262622),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'ACTIVE QUEUE',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textSecondaryDark,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              SizedBox(height: 0.8.h),
                              Text(
                                model.activeQueue,
                                style: AppTextStyles.bodyWhite.copyWith(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.creamText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(4.5.w),
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
                      'Acceptance Settings',
                      style: AppTextStyles.bodyWhite.copyWith(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.creamText,
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Auto-accept subscription requests',
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 13.sp,
                              color: AppColors.textSecondaryDark,
                            ),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.85,
                          child: Switch(
                            value: state.autoAcceptSubscription,
                            onChanged: notifier.toggleAutoAccept,
                            activeTrackColor: AppColors.success,
                            activeThumbColor: Colors.white,
                            inactiveTrackColor: AppColors.darkBorder,
                            inactiveThumbColor: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(4.5.w),
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
                      'Auto-Offline Schedule',
                      style: AppTextStyles.bodyWhite.copyWith(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.creamText,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Daily closing time',
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 13.sp,
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                        Text(
                          model.dailyClosingTime,
                          style: AppTextStyles.bodyWhite.copyWith(
                            fontSize: 13.5.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Afternoon break slot',
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 13.sp,
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                        Text(
                          model.afternoonBreakSlot,
                          style: AppTextStyles.bodyWhite.copyWith(
                            fontSize: 13.5.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: double.infinity,
                height: 6.h,
                child: ElevatedButton(
                  onPressed: () {
                    notifier.setOffline();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Kitchen status updated to Offline'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE25C57),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    state.isOnline ? 'Go Offline Now' : 'Go Online Now',
                    style: AppTextStyles.buttonMedium.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
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
