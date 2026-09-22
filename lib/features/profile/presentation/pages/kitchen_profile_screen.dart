import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/kitchen_profile_provider.dart';

class KitchenProfileScreen extends ConsumerWidget {
  const KitchenProfileScreen({super.key});

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
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.creamText,
            ),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 13.sp,
              color: AppColors.creamText,
            ),
            decoration: InputDecoration(
              hintText: 'Enter $title',
              hintStyle: AppTextStyles.caption.copyWith(
                color: AppColors.textMutedDark,
              ),
              filled: true,
              fillColor: const Color(0xFF171715),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 3.5.w,
                vertical: 1.5.h,
              ),
              enabledBorder: OutlineInputBorder(
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
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
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

  void _showImagePickerSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF171715),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: Color(0xFF262622), width: 1),
      ),
      builder: (sheetCtx) {
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
                  'Update Kitchen Cover Photo',
                  style: AppTextStyles.headingWhite.copyWith(
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.creamText,
                  ),
                ),
                SizedBox(height: 1.8.h),
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.photo_library_outlined,
                      color: AppColors.primary,
                      size: 16.sp,
                    ),
                  ),
                  title: Text(
                    'Choose from Gallery',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.creamText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(sheetCtx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Gallery photo updated successfully!'),
                        backgroundColor: AppColors.success,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.primary,
                      size: 16.sp,
                    ),
                  ),
                  title: Text(
                    'Take a Photo',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.creamText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(sheetCtx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Photo captured and updated!'),
                        backgroundColor: AppColors.success,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEditableRow({
    required BuildContext context,
    required String label,
    required String value,
    required VoidCallback onEdit,
  }) {
    return InkWell(
      onTap: onEdit,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  SizedBox(height: 0.5.h),
                  Text(
                    value,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.creamText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 2.w),
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
    final state = ref.watch(kitchenProfileProvider);
    final notifier = ref.read(kitchenProfileProvider.notifier);
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
                          'Kitchen Profile',
                          style: AppTextStyles.headingWhite.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.creamText,
                          ),
                        ),
                        Text(
                          'Your public brand details',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
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
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.asset(
                              model.bannerImagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: const Color(0xFF22221F),
                                  child: Icon(
                                    Icons.restaurant_rounded,
                                    color: AppColors.primary,
                                    size: 28.sp,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          top: 1.5.h,
                          right: 3.w,
                          child: GestureDetector(
                            onTap: () => _showImagePickerSheet(context, ref),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 3.w,
                                vertical: 0.8.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF11110F).withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.primary.withValues(alpha: 0.7),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.photo_camera_outlined,
                                    color: AppColors.primary,
                                    size: 14.sp,
                                  ),
                                  SizedBox(width: 1.5.w),
                                  Text(
                                    'Edit Cover',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 2.h,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                model.kitchenName,
                                style: AppTextStyles.headingWhite.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              GestureDetector(
                                onTap: () {
                                  _showEditFieldDialog(
                                    context: context,
                                    title: 'Kitchen Name',
                                    initialValue: model.kitchenName,
                                    onSave: (val) =>
                                        notifier.updateKitchenName(val),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(1.w),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF22221E),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icon(
                                    Icons.edit_outlined,
                                    color: AppColors.primary,
                                    size: 13.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 0.8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...List.generate(5, (index) {
                                return Icon(
                                  index < model.rating.floor()
                                      ? Icons.star_rounded
                                      : (index < model.rating
                                          ? Icons.star_half_rounded
                                          : Icons.star_outline_rounded),
                                  color: const Color(0xFFE5A64E),
                                  size: 16.sp,
                                );
                              }),
                              SizedBox(width: 2.w),
                              Text(
                                '${model.rating} (${model.reviewsCount} reviews)',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondaryDark,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 1.5.h,
                ),
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
                    _buildEditableRow(
                      context: context,
                      label: 'OWNER NAME',
                      value: model.ownerName,
                      onEdit: () {
                        _showEditFieldDialog(
                          context: context,
                          title: 'Owner Name',
                          initialValue: model.ownerName,
                          onSave: (val) => notifier.updateOwnerName(val),
                        );
                      },
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildEditableRow(
                      context: context,
                      label: 'BUSINESS TYPE',
                      value: model.businessType,
                      onEdit: () {
                        _showEditFieldDialog(
                          context: context,
                          title: 'Business Type',
                          initialValue: model.businessType,
                          onSave: (val) => notifier.updateBusinessType(val),
                        );
                      },
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildEditableRow(
                      context: context,
                      label: 'CUISINES',
                      value: model.cuisines,
                      onEdit: () {
                        _showEditFieldDialog(
                          context: context,
                          title: 'Cuisines',
                          initialValue: model.cuisines,
                          onSave: (val) => notifier.updateCuisines(val),
                        );
                      },
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildEditableRow(
                      context: context,
                      label: 'ADDRESS',
                      value: model.address,
                      onEdit: () {
                        _showEditFieldDialog(
                          context: context,
                          title: 'Address',
                          initialValue: model.address,
                          onSave: (val) => notifier.updateAddress(val),
                        );
                      },
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildEditableRow(
                      context: context,
                      label: 'OPERATING HOURS',
                      value: model.operatingHours,
                      onEdit: () {
                        _showEditFieldDialog(
                          context: context,
                          title: 'Operating Hours',
                          initialValue: model.operatingHours,
                          onSave: (val) => notifier.updateOperatingHours(val),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),
              Text(
                'Documents & Licenses',
                style: AppTextStyles.headingWhite.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.creamText,
                ),
              ),
              SizedBox(height: 1.5.h),
              ...model.documents.map((doc) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 1.2.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 1.6.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF171715),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF262622),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.description_outlined,
                            color: AppColors.primary,
                            size: 18.sp,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            doc.title,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.creamText,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: const Color(0xFF22C55E),
                            size: 15.sp,
                          ),
                          SizedBox(width: 1.5.w),
                          Text(
                            'Verified',
                            style: AppTextStyles.caption.copyWith(
                              color: const Color(0xFF22C55E),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 2.h),
              GestureDetector(
                onTap: () async {
                  await notifier.saveChanges();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Kitchen profile updated successfully!'),
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
                          Icons.edit_rounded,
                          color: const Color(0xFF11110F),
                          size: 16.sp,
                        ),
                        SizedBox(width: 2.5.w),
                        Text(
                          state.isSaving ? 'Saving...' : 'Save Changes',
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
