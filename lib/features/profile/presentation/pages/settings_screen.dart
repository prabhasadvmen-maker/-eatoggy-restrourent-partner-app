import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  void _showChangePasswordDialog(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1C1C1A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF262622), width: 1),
          ),
          title: Text(
            'Change Password',
            style: AppTextStyles.headingWhite.copyWith(
              fontSize: 14.5.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.creamText,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: oldPasswordController,
                obscureText: true,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.creamText,
                ),
                decoration: InputDecoration(
                  hintText: 'Current Password',
                  hintStyle: AppTextStyles.caption.copyWith(
                    color: AppColors.textMutedDark,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF171715),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFF262622)),
                  ),
                ),
              ),
              SizedBox(height: 1.5.h),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.creamText,
                ),
                decoration: InputDecoration(
                  hintText: 'New Password',
                  hintStyle: AppTextStyles.caption.copyWith(
                    color: AppColors.textMutedDark,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF171715),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFF262622)),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'Cancel',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondaryDark,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password updated successfully!'),
                    backgroundColor: AppColors.success,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text(
                'Update',
                style: AppTextStyles.caption.copyWith(
                  color: const Color(0xFF11110F),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showChangePhoneDialog(BuildContext context) {
    final phoneController = TextEditingController(text: '+91 98765 43210');

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1C1C1A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF262622), width: 1),
          ),
          title: Text(
            'Change Phone Number',
            style: AppTextStyles.headingWhite.copyWith(
              fontSize: 14.5.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.creamText,
            ),
          ),
          content: TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.creamText,
            ),
            decoration: InputDecoration(
              hintText: 'Enter new phone number',
              hintStyle: AppTextStyles.caption.copyWith(
                color: AppColors.textMutedDark,
              ),
              filled: true,
              fillColor: const Color(0xFF171715),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF262622)),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'Cancel',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondaryDark,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Verification OTP sent to new number!'),
                    backgroundColor: AppColors.success,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text(
                'Send OTP',
                style: AppTextStyles.caption.copyWith(
                  color: const Color(0xFF11110F),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLanguageSelector(
    BuildContext context,
    String currentLang,
    void Function(String) onSelect,
  ) {
    const languages = [
      'English',
      'Hindi',
      'Kannada',
      'Tamil',
      'Telugu',
      'Marathi',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF171715),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: Color(0xFF262622), width: 1),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 10.w,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF333330),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Select App Language',
                  style: AppTextStyles.headingWhite.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.creamText,
                  ),
                ),
                SizedBox(height: 1.5.h),
                ...languages.map((lang) {
                  final isSelected = lang == currentLang;
                  return GestureDetector(
                    onTap: () {
                      onSelect(lang);
                      Navigator.pop(ctx);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 1.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.4.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withValues(alpha: 0.15)
                            : const Color(0xFF1E1E1C),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : const Color(0xFF262622),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            lang,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontSize: 13.sp,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.creamText,
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.primary,
                              size: 16.sp,
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1C1C1A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFF262622), width: 1),
          ),
          title: Text(
            'Logout Account',
            style: AppTextStyles.headingWhite.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.creamText,
            ),
          ),
          content: Text(
            'Are you sure you want to log out from your restaurant partner portal?',
            style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondaryDark,
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'Cancel',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondaryDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              ),
              onPressed: () {
                Navigator.pop(ctx);
                context.go(AppRoutes.login);
              },
              child: Text(
                'Logout',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTextStyles.caption.copyWith(
        color: const Color(0xFFE5A64E),
        fontWeight: FontWeight.w800,
        letterSpacing: 0.6,
      ),
    );
  }

  Widget _buildNavRow({
    required String title,
    String? trailingText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.creamText,
              ),
            ),
            Row(
              children: [
                if (trailingText != null) ...[
                  Text(
                    trailingText,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondaryDark,
                      fontSize: 11.5.sp,
                    ),
                  ),
                  SizedBox(width: 1.w),
                ],
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textSecondaryDark,
                  size: 18.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleRow({
    required String title,
    required bool value,
    required VoidCallback onToggle,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.creamText,
            ),
          ),
          Switch(
            value: value,
            onChanged: (_) => onToggle(),
            activeTrackColor: const Color(0xFF22C55E),
            activeThumbColor: const Color(0xFFFFF1D2),
            inactiveTrackColor: const Color(0xFF2E2E2A),
            inactiveThumbColor: const Color(0xFFFFF1D2),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
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
                          'Settings',
                          style: AppTextStyles.headingWhite.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.creamText,
                          ),
                        ),
                        Text(
                          'Preferences and account control',
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
              _buildSectionHeader('ACCOUNT SETTINGS'),
              SizedBox(height: 1.2.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF171715),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF262622),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _buildNavRow(
                      title: 'Change Password',
                      onTap: () => _showChangePasswordDialog(context),
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildNavRow(
                      title: 'Change Phone Number',
                      onTap: () => _showChangePhoneDialog(context),
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildNavRow(
                      title: 'App Language',
                      trailingText: model.language,
                      onTap: () {
                        _showLanguageSelector(
                          context,
                          model.language,
                          (lang) => notifier.updateLanguage(lang),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),
              _buildSectionHeader('NOTIFICATION PREFERENCES'),
              SizedBox(height: 1.2.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF171715),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF262622),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _buildToggleRow(
                      title: 'Order Alerts',
                      value: model.orderAlerts,
                      onToggle: () => notifier.toggleOrderAlerts(),
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildToggleRow(
                      title: 'Subscription Reminders',
                      value: model.subscriptionReminders,
                      onToggle: () => notifier.toggleSubscriptionReminders(),
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildToggleRow(
                      title: 'Promotional Notifications',
                      value: model.promotionalNotifications,
                      onToggle: () => notifier.togglePromotionalNotifications(),
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildToggleRow(
                      title: 'Alert Sound',
                      value: model.alertSound,
                      onToggle: () => notifier.toggleAlertSound(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),
              _buildSectionHeader('BUSINESS TOOLS'),
              SizedBox(height: 1.2.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF171715),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF262622),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _buildNavRow(
                      title: 'Bank Account Details',
                      onTap: () {
                        context.push(AppRoutes.bankAccountDetails);
                      },
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildNavRow(
                      title: 'Tax Information (GSTIN)',
                      onTap: () {
                        context.push(AppRoutes.taxInformation);
                      },
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildNavRow(
                      title: 'Thermal Printer Setup',
                      onTap: () {
                        context.push(AppRoutes.thermalPrinter);
                      },
                    ),
                  ],
                ),
              ),
           
           
              SizedBox(height: 3.h),
              Center(
                child: Text(
                  model.appVersion,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textMutedDark,
                    fontSize: 13.sp,
                  ),
                ),
              ),
              SizedBox(height: 1.5.h),
              GestureDetector(
                onTap: () => _showLogoutDialog(context),
                child: Container(
                  width: double.infinity,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1414),
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
                      SizedBox(width: 2.w),
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
}
