import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/business_tools_provider.dart';

class TaxInformationScreen extends ConsumerWidget {
  const TaxInformationScreen({super.key});

  void _showEditGstinDialog(BuildContext context, WidgetRef ref, String initial) {
    final controller = TextEditingController(text: initial);
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
            'Edit GSTIN',
            style: AppTextStyles.headingWhite.copyWith(
              fontSize: 14.5.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.creamText,
            ),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.characters,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.creamText,
            ),
            decoration: InputDecoration(
              hintText: 'Enter 15-digit GSTIN',
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
                final text = controller.text.trim().toUpperCase();
                if (text.isNotEmpty) {
                  ref
                      .read(taxInformationProvider.notifier)
                      .updateGstin(text);
                }
                Navigator.pop(ctx);
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

  Widget _buildDetailRow({
    required String label,
    required String value,
    VoidCallback? onEdit,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
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
          ),
          if (onEdit != null)
            GestureDetector(
              onTap: onEdit,
              child: Container(
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
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taxInformationProvider);
    final notifier = ref.read(taxInformationProvider.notifier);
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
                          'Tax Information',
                          style: AppTextStyles.headingWhite.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.creamText,
                          ),
                        ),
                        Text(
                          'Goods and Services Tax compliance',
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
                padding: EdgeInsets.all(4.5.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF171715),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF262622),
                    width: 1,
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
                              Icons.verified_user_rounded,
                              color: AppColors.primary,
                              size: 18.sp,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              'GSTIN Registration',
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.w700,
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
                                'Active',
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
                    SizedBox(height: 1.5.h),
                    Text(
                      model.gstin,
                      style: AppTextStyles.headingWhite.copyWith(
                        fontSize: 16.sp,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 0.6.h),
                    Text(
                      model.legalBusinessName,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondaryDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),
              Text(
                'Registration Details',
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
                    _buildDetailRow(
                      label: 'LEGAL BUSINESS NAME',
                      value: model.legalBusinessName,
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildDetailRow(
                      label: 'GSTIN NUMBER',
                      value: model.gstin,
                      onEdit: () =>
                          _showEditGstinDialog(context, ref, model.gstin),
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildDetailRow(
                      label: 'PAN NUMBER',
                      value: model.panNumber,
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildDetailRow(
                      label: 'TAXPAYER TYPE',
                      value: model.taxpayerType,
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildDetailRow(
                      label: 'REGISTERED PLACE OF BUSINESS',
                      value: model.registeredAddress,
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildDetailRow(
                      label: 'STATE JURISDICTION',
                      value: model.stateJurisdiction,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('GST Certificate downloaded to device.'),
                      backgroundColor: AppColors.success,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 1.8.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF171715),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.6),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.download_rounded,
                        color: AppColors.primary,
                        size: 16.sp,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Download GST Certificate',
                        style: AppTextStyles.buttonMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 1.5.h),
              GestureDetector(
                onTap: () async {
                  await notifier.save();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tax information updated successfully!'),
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
                          state.isSaving ? 'Saving...' : 'Save Tax Details',
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
