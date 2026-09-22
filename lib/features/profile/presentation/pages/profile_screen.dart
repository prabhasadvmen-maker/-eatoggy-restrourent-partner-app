import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/account_settings_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF2E2E2A)),
        ),
        title: Text(
          'Logout Account',
          style: AppTextStyles.headingWhite.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.error,
          ),
        ),
        content: Text(
          'Are you sure you want to log out of your restaurant partner account?',
          style: AppTextStyles.body.copyWith(
            color: AppColors.creamText,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Cancel',
              style: AppTextStyles.captionMedium.copyWith(
                color: AppColors.textSecondaryDark,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              minimumSize: Size.zero,
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              context.go(AppRoutes.login);
            },
            child: Text(
              'Logout',
              style: AppTextStyles.buttonMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(accountSettingsProvider);
    final notifier = ref.read(accountSettingsProvider.notifier);
    final model = state.model;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.5.h),
              Text(
                'Account & Settings',
                style: AppTextStyles.headingWhite.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.creamText,
                ),
              ),
              SizedBox(height: 0.6.h),
              Text(
                'Manage your kitchen profile and business details',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondaryDark,
                ),
              ),
              SizedBox(height: 2.5.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF171715),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF262622),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        model.avatarUrl,
                        width: 15.w,
                        height: 15.w,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(
                          width: 15.w,
                          height: 15.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFF242420),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person_rounded,
                            color: AppColors.primary,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.bistroName,
                            style: AppTextStyles.headingWhite.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.creamText,
                            ),
                          ),
                          SizedBox(height: 0.4.h),
                          Text(
                            '${model.chefName} • ${model.role}',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondaryDark,
                            ),
                          ),
                          SizedBox(height: 0.8.h),
                          GestureDetector(
                            onTap: () => notifier.togglePartnerStatus(),
                            child: Row(
                              children: [
                                Container(
                                  width: 7,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    color: model.isActive
                                        ? const Color(0xFF4CAF50)
                                        : AppColors.textMuted,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 1.8.w),
                                Text(
                                  model.statusText,
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: model.isActive
                                        ? const Color(0xFF4CAF50)
                                        : AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),
              Container(
                width: double.infinity,
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
                    _buildSettingsTile(
                      icon: Icons.person_outline_rounded,
                      title: 'Edit Profile',
                      subtitle: 'Personal info & business documents',
                      onTap: () => context.push(AppRoutes.editProfile),
                    ),
                    const Divider(
                      height: 1,
                      color: Color(0xFF242420),
                      indent: 16,
                      endIndent: 16,
                    ),
                    _buildSettingsTile(
                      icon: Icons.star_outline_rounded,
                      title: 'View Ratings',
                      subtitle:
                          '${model.avgRating} Avg Rating • ${model.reviewCount} reviews',
                      trailingBadge: model.hasNewFeedback
                          ? Container(
                              margin: EdgeInsets.only(right: 2.w),
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.2.w,
                                vertical: 0.4.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2E2416),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: const Color(0xFF44341B),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'New Feedback',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            )
                          : null,
                      onTap: () {
                        ref
                            .read(accountSettingsProvider.notifier)
                            .clearNewFeedbackBadge();
                        context.push(AppRoutes.ratingsAndReviews);
                      },
                    ),
                    const Divider(
                      height: 1,
                      color: Color(0xFF242420),
                      indent: 16,
                      endIndent: 16,
                    ),
                    _buildSettingsTile(
                      icon: Icons.trending_up_rounded,
                      title: 'Revenue & Earnings',
                      subtitle: 'This week: ${model.weeklyEarnings}',
                      onTap: () => context.push(AppRoutes.revenueEarnings),
                    ),
                    const Divider(
                      height: 1,
                      color: Color(0xFF242420),
                      indent: 16,
                      endIndent: 16,
                    ),
                    _buildSettingsTile(
                      icon: Icons.storefront_outlined,
                      title: 'Kitchen Profile',
                      subtitle: model.kitchenProfileSummary,
                      onTap: () => context.push(AppRoutes.kitchenProfile),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),
              Container(
                width: double.infinity,
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
                    _buildSettingsTile(
                      icon: Icons.chat_bubble_outline_rounded,
                      title: 'Help & Support',
                      subtitle: 'FAQs, support tickets, contact us',
                      onTap: () => context.push(AppRoutes.helpSupport),
                    ),
                    const Divider(
                      height: 1,
                      color: Color(0xFF242420),
                      indent: 16,
                      endIndent: 16,
                    ),
                    _buildSettingsTile(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      subtitle: 'App notifications, security details',
                      onTap: () => context.push(AppRoutes.settings),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),
              GestureDetector(
                onTap: () => _showLogoutDialog(context),
                child: Container(
                  width: double.infinity,
                  height: 6.2.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF381C1C),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        color: AppColors.error,
                        size: 18.sp,
                      ),
                      SizedBox(width: 2.5.w),
                      Text(
                        'Logout Account',
                        style: AppTextStyles.buttonMedium.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.error,
                        ),
                      ),
                    ],
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

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailingBadge,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.8.h),
        child: Row(
          children: [
            Container(
              width: 10.5.w,
              height: 10.5.w,
              decoration: BoxDecoration(
                color: const Color(0xFF22221F),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
              ),
            ),
            SizedBox(width: 3.5.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.creamText,
                    ),
                  ),
                  SizedBox(height: 0.3.h),
                  Text(
                    subtitle,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondaryDark,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            ?trailingBadge,
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondaryDark,
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }
}
