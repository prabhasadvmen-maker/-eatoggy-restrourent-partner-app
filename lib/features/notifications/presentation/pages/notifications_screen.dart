import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/notifications_provider.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationsProvider);
    final notifier = ref.read(notificationsProvider.notifier);
    final model = state.model;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.primary,
            size: 20,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          model.title,
          style: AppTextStyles.title.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.creamText,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              notifier.markAllRead();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All notifications marked as read')),
              );
            },
            child: Text(
              model.actionText,
              style: AppTextStyles.caption.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...model.sections.map((section) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.sectionTitle,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  ...section.items.map((item) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 1.8.h),
                      child: GestureDetector(
                        onTap: () => notifier.markItemRead(item.id),
                        child: Container(
                          width: double.infinity,
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (item.isUnread) ...[
                                    Container(
                                      width: 2.w,
                                      height: 2.w,
                                      margin: EdgeInsets.only(right: 2.5.w),
                                      decoration: const BoxDecoration(
                                        color: AppColors.primary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                  Expanded(
                                    child: Text(
                                      item.title,
                                      style: AppTextStyles.bodyWhite.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.creamText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 0.6.h),
                              Padding(
                                padding: EdgeInsets.only(left: item.isUnread ? 4.5.w : 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.description,
                                      style: AppTextStyles.caption.copyWith(
                                        fontSize: 12.sp,
                                        color: AppColors.textSecondaryDark,
                                      ),
                                    ),
                                    SizedBox(height: 0.8.h),
                                    Text(
                                      item.timeAgo,
                                      style: AppTextStyles.caption.copyWith(
                                        fontSize: 11.5.sp,
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 1.h),
                ],
              );
            }),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }
}
