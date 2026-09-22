import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/business_tools_provider.dart';

class BankAccountDetailsScreen extends ConsumerWidget {
  const BankAccountDetailsScreen({super.key});

  void _showEditFieldDialog({
    required BuildContext context,
    required String title,
    required String initialValue,
    required void Function(String) onSave,
  }) {
    final controller = TextEditingController(text: initialValue);
    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1C1C1A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF262622), width: 1),
          ),
          title: Text(
            'Edit $title',
            style: AppTextStyles.headingWhite.copyWith(
              fontSize: 14.5.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.creamText,
            ),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.creamText,
            ),
            decoration: InputDecoration(
              hintText: 'Enter $title',
              hintStyle: AppTextStyles.caption.copyWith(
                color: AppColors.textMutedDark,
              ),
              filled: true,
              fillColor: const Color(0xFF171715),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF262622)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
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
                final text = controller.text.trim();
                if (text.isNotEmpty) {
                  onSave(text);
                }
                Navigator.pop(dialogCtx);
              },
              child: Text(
                'Save',
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

  Widget _buildRow({
    required BuildContext context,
    required String label,
    required String value,
    required VoidCallback onEdit,
  }) {
    return InkWell(
      onTap: onEdit,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.9.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textMutedDark,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 0.4.h),
                Text(
                  value,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.creamText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(1.8.w),
              decoration: BoxDecoration(
                color: const Color(0xFF22221E),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF2E2E28),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.edit_outlined,
                color: AppColors.primary,
                size: 15.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bankAccountProvider);
    final notifier = ref.read(bankAccountProvider.notifier);
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
                          'Bank Account Details',
                          style: AppTextStyles.headingWhite.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.creamText,
                          ),
                        ),
                        Text(
                          'Payout settlement account details',
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
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF23231F), Color(0xFF171715)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    width: 1.2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_balance_rounded,
                              color: AppColors.primary,
                              size: 20.sp,
                            ),
                            SizedBox(width: 2.5.w),
                            Text(
                              model.bankName,
                              style: AppTextStyles.headingWhite.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.creamText,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.5.w,
                            vertical: 0.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B3820),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFF22C55E),
                              width: 0.8,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle_rounded,
                                color: const Color(0xFF22C55E),
                                size: 12.sp,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                'Verified',
                                style: AppTextStyles.caption.copyWith(
                                  color: const Color(0xFF22C55E),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      model.maskedAccountNumber,
                      style: AppTextStyles.headingWhite.copyWith(
                        fontSize: 17.sp,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w700,
                        color: AppColors.creamText,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BENEFICIARY',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textMutedDark,
                                fontSize: 9.5.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 0.3.h),
                            Text(
                              model.beneficiaryName,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.creamText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'IFSC CODE',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textMutedDark,
                                fontSize: 9.5.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 0.3.h),
                            Text(
                              model.ifscCode,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),
              Text(
                'Account Information',
                style: AppTextStyles.headingWhite.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.creamText,
                ),
              ),
              SizedBox(height: 1.2.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 1.5.h,
                ),
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
                    _buildRow(
                      context: context,
                      label: 'BANK NAME',
                      value: model.bankName,
                      onEdit: () {
                        _showEditFieldDialog(
                          context: context,
                          title: 'Bank Name',
                          initialValue: model.bankName,
                          onSave: (val) =>
                              notifier.updateDetails(bankName: val),
                        );
                      },
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildRow(
                      context: context,
                      label: 'ACCOUNT NUMBER',
                      value: model.accountNumber,
                      onEdit: () {
                        _showEditFieldDialog(
                          context: context,
                          title: 'Account Number',
                          initialValue: model.accountNumber,
                          onSave: (val) =>
                              notifier.updateDetails(accountNumber: val),
                        );
                      },
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildRow(
                      context: context,
                      label: 'IFSC CODE',
                      value: model.ifscCode,
                      onEdit: () {
                        _showEditFieldDialog(
                          context: context,
                          title: 'IFSC Code',
                          initialValue: model.ifscCode,
                          onSave: (val) =>
                              notifier.updateDetails(ifscCode: val),
                        );
                      },
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildRow(
                      context: context,
                      label: 'ACCOUNT HOLDER NAME',
                      value: model.beneficiaryName,
                      onEdit: () {
                        _showEditFieldDialog(
                          context: context,
                          title: 'Account Holder Name',
                          initialValue: model.beneficiaryName,
                          onSave: (val) =>
                              notifier.updateDetails(beneficiaryName: val),
                        );
                      },
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildRow(
                      context: context,
                      label: 'ACCOUNT TYPE',
                      value: model.accountType,
                      onEdit: () {
                        _showEditFieldDialog(
                          context: context,
                          title: 'Account Type',
                          initialValue: model.accountType,
                          onSave: (val) =>
                              notifier.updateDetails(accountType: val),
                        );
                      },
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildRow(
                      context: context,
                      label: 'BRANCH',
                      value: model.branch,
                      onEdit: () {
                        _showEditFieldDialog(
                          context: context,
                          title: 'Branch',
                          initialValue: model.branch,
                          onSave: (val) =>
                              notifier.updateDetails(branch: val),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),
              GestureDetector(
                onTap: () async {
                  await notifier.save();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Bank account details saved successfully!'),
                        backgroundColor: AppColors.success,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_rounded,
                          color: const Color(0xFF11110F),
                          size: 18.sp,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          state.isSaving ? 'Saving...' : 'Save Bank Details',
                          style: AppTextStyles.buttonMedium.copyWith(
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF11110F),
                          ),
                        ),
                      ],
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
