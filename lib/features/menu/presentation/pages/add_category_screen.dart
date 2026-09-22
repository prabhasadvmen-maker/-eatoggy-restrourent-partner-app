import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/add_category_model.dart';
import '../../data/models/menu_management_model.dart';
import '../providers/add_category_provider.dart';

class AddCategoryScreen extends ConsumerStatefulWidget {
  const AddCategoryScreen({
    super.key,
    this.isEdit = false,
    this.category,
    this.categoryName,
  });

  final bool isEdit;
  final MenuCategoryItem? category;
  final String? categoryName;

  @override
  ConsumerState<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends ConsumerState<AddCategoryScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    final defaultModel =
        widget.isEdit ? AddCategoryModel.dummyEdit : AddCategoryModel.dummyNew;

    String initialName = widget.category?.title ?? widget.categoryName ?? defaultModel.categoryName;
    String initialDescription = defaultModel.description;

    _nameController = TextEditingController(text: initialName);
    _descriptionController = TextEditingController(text: initialDescription);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(addCategoryProvider.notifier).initialize(
            isEdit: widget.isEdit,
            category: widget.category,
            categoryName: widget.categoryName,
          );
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _showImagePickerBottomSheet(
      BuildContext context, AddCategoryNotifier notifier) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: Color(0xFF2E2E2A)),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Upload Category Image',
                      style: AppTextStyles.headingWhite.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.creamText,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close_rounded,
                        color: AppColors.textMuted,
                        size: 18.sp,
                      ),
                      onPressed: () => Navigator.of(bottomSheetContext).pop(),
                    ),
                  ],
                ),
                SizedBox(height: 1.5.h),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 11.w,
                    height: 11.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: AppColors.primary,
                      size: 17.sp,
                    ),
                  ),
                  title: Text(
                    'Take Photo with Camera',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.creamText,
                    ),
                  ),
                  subtitle: Text(
                    'Capture dish category image directly',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondaryDark,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(bottomSheetContext).pop();
                    notifier.pickImage(ImageSource.camera);
                  },
                ),
                Divider(color: const Color(0xFF2B2B26), height: 2.h),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 11.w,
                    height: 11.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.photo_library_rounded,
                      color: AppColors.primary,
                      size: 17.sp,
                    ),
                  ),
                  title: Text(
                    'Choose from Gallery',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.creamText,
                    ),
                  ),
                  subtitle: Text(
                    'Pick category photo from your phone storage',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondaryDark,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(bottomSheetContext).pop();
                    notifier.pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSaveCategory() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isEdit
                ? 'Category updated successfully!'
                : 'Category added successfully!',
            style: AppTextStyles.caption.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 2),
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addCategoryProvider);
    final notifier = ref.read(addCategoryProvider.notifier);
    final model = state.model;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Form(
                  key: _formKey,
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
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: AppColors.primary,
                                  size: 15.sp,
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
                                  model.title,
                                  style: AppTextStyles.headingWhite.copyWith(
                                    fontSize: 17.5.sp,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.creamText,
                                  ),
                                ),
                                SizedBox(height: 0.3.h),
                                Text(
                                  model.subtitle,
                                  style: AppTextStyles.caption.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColors.textSecondaryDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.5.h),
                      Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  _showImagePickerBottomSheet(context, notifier),
                              child: CustomPaint(
                                painter: _DashedCirclePainter(
                                  color: AppColors.primary,
                                  strokeWidth: 1.5,
                                  gap: 5.0,
                                ),
                                child: Container(
                                  width: 26.w,
                                  height: 26.w,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF171715),
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child: state.imagePath != null
                                        ? Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Image.file(
                                                File(state.imagePath!),
                                                fit: BoxFit.cover,
                                              ),
                                              Positioned(
                                                right: 1.w,
                                                top: 1.w,
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      notifier.removeImage(),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.black87,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                      Icons.close_rounded,
                                                      size: 11.sp,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Center(
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              color: AppColors.primary,
                                              size: 26.sp,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 1.8.h),
                            Text(
                              'Upload Category Image',
                              style: AppTextStyles.headingWhite.copyWith(
                                fontSize: 14.5.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.creamText,
                              ),
                            ),
                            SizedBox(height: 0.6.h),
                            Text(
                              'JPG or PNG, max 2MB (Square ratio preferred)',
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 11.5.sp,
                                color: AppColors.textMutedDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Category Name *',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.creamText,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF171715),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF262622),
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          controller: _nameController,
                          style: AppTextStyles.body.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.creamText,
                          ),
                          decoration: InputDecoration(
                            hintText: 'e.g. Desserts, North Indian, Beverages',
                            hintStyle: AppTextStyles.caption.copyWith(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF555550),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 1.6.h,
                            ),
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Please enter category name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 2.5.h),
                      Text(
                        'Description',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.creamText,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF171715),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF262622),
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          controller: _descriptionController,
                          maxLines: 4,
                          style: AppTextStyles.body.copyWith(
                            fontSize: 13.5.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.creamText,
                            height: 1.4,
                          ),
                          decoration: InputDecoration(
                            hintText:
                                'Describe items in this category... (e.g. Traditional clay oven baked breads and curries)',
                            hintStyle: AppTextStyles.caption.copyWith(
                              fontSize: 13.sp,
                              color: const Color(0xFF555550),
                              height: 1.4,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 1.6.h,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.5.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 1.2.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF171715),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFF262622),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Active Status',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontSize: 13.5.sp,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.creamText,
                                  ),
                                ),
                                SizedBox(height: 0.3.h),
                                Text(
                                  'Visible to customers in digital menu',
                                  style: AppTextStyles.caption.copyWith(
                                    fontSize: 11.5.sp,
                                    color: AppColors.textSecondaryDark,
                                  ),
                                ),
                              ],
                            ),
                            Transform.scale(
                              scale: 0.85,
                              child: Switch(
                                value: state.isActive,
                                onChanged: (val) {
                                  notifier.toggleActive(val);
                                },
                                activeTrackColor: const Color(0xFF285430),
                                activeThumbColor: const Color(0xFFFFF1D2),
                                inactiveTrackColor: const Color(0xFF2B2B28),
                                inactiveThumbColor: const Color(0xFF8A8A85),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 2.h),
              child: SizedBox(
                width: double.infinity,
                height: 6.h,
                child: ElevatedButton(
                  onPressed: _onSaveCategory,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Save Category',
                    style: AppTextStyles.buttonMedium.copyWith(
                      fontSize: 14.5.sp,
                      fontWeight: FontWeight.w800,
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
}

class _DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  _DashedCirclePainter({
    required this.color,
    required this.strokeWidth,
    required this.gap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final Offset center = Offset(radius, radius);
    final double circumference = 2 * 3.141592653589793 * radius;
    final int dashCount = (circumference / (gap * 2)).floor();
    final double dashAngle = (2 * 3.141592653589793) / dashCount;

    for (int i = 0; i < dashCount; i++) {
      final double startAngle = i * dashAngle;
      final double sweepAngle = dashAngle * 0.55;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DashedCirclePainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.gap != gap;
}
