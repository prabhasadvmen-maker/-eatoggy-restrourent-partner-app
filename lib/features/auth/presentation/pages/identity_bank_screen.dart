import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/identity_bank_provider.dart';

class IdentityBankScreen extends ConsumerStatefulWidget {
  const IdentityBankScreen({super.key});

  @override
  ConsumerState<IdentityBankScreen> createState() => _IdentityBankScreenState();
}

class _IdentityBankScreenState extends ConsumerState<IdentityBankScreen> {
  late final TextEditingController _accountHolderController;
  late final TextEditingController _accountNumberController;
  late final TextEditingController _ifscController;
  late final TextEditingController _bankNameController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(identityBankProvider);
    _accountHolderController =
        TextEditingController(text: state.accountHolderName);
    _accountNumberController = TextEditingController(text: state.accountNumber);
    _ifscController = TextEditingController(text: state.ifscCode);
    _bankNameController = TextEditingController(text: state.bankName);
  }

  @override
  void dispose() {
    _accountHolderController.dispose();
    _accountNumberController.dispose();
    _ifscController.dispose();
    _bankNameController.dispose();
    super.dispose();
  }

  void _onContinue() {
    ref.read(identityBankProvider.notifier).submitIdentityBank(
      onSuccess: () {
        if (!mounted) return;
        context.push(AppRoutes.reviewApplication);
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

  void _showImageSourcePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.5.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upload Aadhaar Card',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 2.h),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary.withAlpha(30),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                  title: Text(
                    'Take Photo with Camera',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    ref
                        .read(identityBankProvider.notifier)
                        .pickAadhaar(ImageSource.camera);
                  },
                ),
                // ListTile(
                //   leading: CircleAvatar(
                //     backgroundColor: AppColors.primary.withAlpha(30),
                //     child: const Icon(
                //       Icons.photo_library_rounded,
                //       color: AppColors.primary,
                //     ),
                //   ),
                //   title: Text(
                //     'Choose from Gallery',
                //     style: AppTextStyles.bodyMedium.copyWith(
                //       color: AppColors.textSecondary,
                //     ),
                //   ),
                //   onTap: () {
                //     Navigator.pop(bottomSheetContext);
                //     ref
                //         .read(identityBankProvider.notifier)
                //         .pickAadhaar(ImageSource.gallery);
                //   },
                // ),
             
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(identityBankProvider);
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Container(
                        height: 3,
                        width: constraints.maxWidth,
                        color: AppColors.darkBorder,
                      ),
                      Container(
                        height: 3,
                        width: constraints.maxWidth * 0.75,
                        color: AppColors.primary,
                      ),
                    ],
                  );
                },
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
                    _buildAadhaarCard(context, state),
                    SizedBox(height: 3.h),
                    Text(
                      data.bankDetailsHeading,
                      style: AppTextStyles.subhead.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    _buildFieldLabel(data.accountHolderLabel),
                    SizedBox(height: 1.h),
                    _buildInputField(
                      controller: _accountHolderController,
                      hintText: data.accountHolderHint,
                      onChanged: (val) => ref
                          .read(identityBankProvider.notifier)
                          .updateAccountHolderName(val),
                    ),
                    SizedBox(height: 2.2.h),
                    _buildFieldLabel(data.accountNumberLabel),
                    SizedBox(height: 1.h),
                    _buildInputField(
                      controller: _accountNumberController,
                      hintText: data.accountNumberHint,
                      keyboardType: TextInputType.number,
                      onChanged: (val) => ref
                          .read(identityBankProvider.notifier)
                          .updateAccountNumber(val),
                    ),
                    SizedBox(height: 2.2.h),
                    _buildFieldLabel(data.ifscLabel),
                    SizedBox(height: 1.h),
                    _buildInputField(
                      controller: _ifscController,
                      hintText: data.ifscHint,
                      textCapitalization: TextCapitalization.characters,
                      onChanged: (val) => ref
                          .read(identityBankProvider.notifier)
                          .updateIfscCode(val),
                    ),
                    SizedBox(height: 2.2.h),
                    _buildFieldLabel(data.bankNameLabel),
                    SizedBox(height: 1.h),
                    _buildInputField(
                      controller: _bankNameController,
                      hintText: data.bankNameHint,
                      onChanged: (val) => ref
                          .read(identityBankProvider.notifier)
                          .updateBankName(val),
                    ),
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
                  onPressed: state.isLoading ? null : _onContinue,
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

  Widget _buildAadhaarCard(BuildContext context, IdentityBankState state) {
    final data = state.data;
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
                data.aadhaarTitle,
                style: AppTextStyles.subheadSecondary.copyWith(
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (state.isAadhaarUploaded)
                Row(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.success,
                      size: 15.sp,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      'Uploaded',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                )
              else
                Text(
                  'Required',
                  style: AppTextStyles.captionPrimary.copyWith(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
            ],
          ),
          SizedBox(height: 1.8.h),
          GestureDetector(
            onTap: () => _showImageSourcePicker(context),
            child: CustomPaint(
              painter: DashedBorderPainter(
                color: AppColors.primary.withAlpha(180),
                strokeWidth: 1.2,
                gap: 5.0,
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.darkSurface.withAlpha(120),
                ),
                child: state.aadhaarPath != null && state.aadhaarPath!.isNotEmpty
                    ? Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(state.aadhaarPath!),
                              height: 12.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.insert_drive_file_rounded,
                                  color: AppColors.primary,
                                  size: 28.sp,
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 1.2.h),
                          Text(
                            'Tap to change photo',
                            style: AppTextStyles.captionPrimary.copyWith(
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            color: AppColors.primary,
                            size: 26.sp,
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            'Tap to upload document',
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            data.aadhaarUploadNote,
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 11.5.sp,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: AppTextStyles.label.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder, width: 1),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        cursorColor: AppColors.primary,
        style: AppTextStyles.bodySecondary.copyWith(
          fontSize: 14.5.sp,
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: false,
          fillColor: Colors.transparent,
          hintText: hintText,
          hintStyle: AppTextStyles.hint,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 1.8.h),
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
    this.dashWidth = 6.0,
  });

  final Color color;
  final double strokeWidth;
  final double gap;
  final double dashWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(12),
        ),
      );

    final Path dashPath = Path();

    for (final PathMetric metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        dashPath.addPath(
          metric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + gap;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gap != gap ||
        oldDelegate.dashWidth != dashWidth;
  }
}
