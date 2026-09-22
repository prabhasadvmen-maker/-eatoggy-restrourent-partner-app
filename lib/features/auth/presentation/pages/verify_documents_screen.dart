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
import '../../data/models/document_verification_model.dart';
import '../providers/document_verification_provider.dart';

class VerifyDocumentsScreen extends ConsumerStatefulWidget {
  const VerifyDocumentsScreen({super.key});

  @override
  ConsumerState<VerifyDocumentsScreen> createState() =>
      _VerifyDocumentsScreenState();
}

class _VerifyDocumentsScreenState
    extends ConsumerState<VerifyDocumentsScreen> {
  void _onContinue() {
    ref.read(documentVerificationProvider.notifier).submitDocuments(
      onSuccess: () {
        if (!mounted) return;
        context.push(AppRoutes.identityBank);
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

  void _showImageSourcePicker(BuildContext context, String docId) {
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
                  'Upload Document',
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
                        .read(documentVerificationProvider.notifier)
                        .pickDocument(docId, ImageSource.camera);
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
                //         .read(documentVerificationProvider.notifier)
                //         .pickDocument(docId, ImageSource.gallery);
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
    final state = ref.watch(documentVerificationProvider);
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
                        width: constraints.maxWidth * 0.5,
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
                    SizedBox(height: 3.h),
                    ...state.documents.map(
                      (doc) => _buildDocumentCard(context, doc),
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

  Widget _buildDocumentCard(BuildContext context, DocumentItem doc) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.5.h),
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
                doc.title,
                style: AppTextStyles.subheadSecondary.copyWith(
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (doc.isUploaded)
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
              else if (doc.isRequired)
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
            onTap: () => _showImageSourcePicker(context, doc.id),
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
                child: doc.filePath != null && doc.filePath!.isNotEmpty
                    ? Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(doc.filePath!),
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
                            doc.uploadNote,
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
