import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/edit_profile_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _openTimeController;
  late TextEditingController _closeTimeController;
  late TextEditingController _minOrderController;
  late TextEditingController _prepTimeController;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final model = ref.read(editProfileProvider).model;
    _nameController = TextEditingController(text: model.kitchenName);
    _bioController = TextEditingController(text: model.bio);
    _openTimeController = TextEditingController(text: model.openTime);
    _closeTimeController = TextEditingController(text: model.closeTime);
    _minOrderController = TextEditingController(text: model.minOrderValue);
    _prepTimeController = TextEditingController(text: model.prepTime);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _openTimeController.dispose();
    _closeTimeController.dispose();
    _minOrderController.dispose();
    _prepTimeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(source: source);
      if (picked != null) {
        ref.read(editProfileProvider.notifier).updateAvatarImage(picked.path);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile photo updated!'),
              backgroundColor: AppColors.success,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (_) {}
  }

  void _showImagePickerModal() {
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
                  'Change Profile Photo',
                  style: AppTextStyles.headingWhite.copyWith(
                    fontSize: 15.sp,
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
                    Navigator.pop(ctx);
                    _pickImage(ImageSource.gallery);
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
                    Navigator.pop(ctx);
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddCuisineModal() {
    const availableCuisines = [
      'South Indian',
      'Mughlai',
      'Biryani',
      'Desserts',
      'Fast Food',
      'Bakery',
      'Italian',
      'Snacks',
      'Healthy Food',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF171715),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: Color(0xFF262622), width: 1),
      ),
      builder: (ctx) {
        final currentCuisines = ref.read(editProfileProvider).model.cuisines;
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
                  'Select Cuisine to Add',
                  style: AppTextStyles.headingWhite.copyWith(
                    // fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.creamText,
                  ),
                ),
                SizedBox(height: 1.5.h),
                Wrap(
                  spacing: 2.5.w,
                  runSpacing: 1.2.h,
                  children: availableCuisines.map((cuisine) {
                    final isAlreadyAdded = currentCuisines.contains(cuisine);
                    return GestureDetector(
                      onTap: () {
                        if (!isAlreadyAdded) {
                          ref
                              .read(editProfileProvider.notifier)
                              .addCuisine(cuisine);
                        }
                        Navigator.pop(ctx);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.5.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          color: isAlreadyAdded
                              ? AppColors.primary.withValues(alpha: 0.15)
                              : const Color(0xFF1E1E1C),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isAlreadyAdded
                                ? AppColors.primary
                                : const Color(0xFF262622),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              cuisine,
                              style: AppTextStyles.caption.copyWith(
                                // fontSize: 11.5.sp,
                                fontWeight: FontWeight.w600,
                                color: isAlreadyAdded
                                    ? AppColors.primary
                                    : AppColors.creamText,
                              ),
                            ),
                            if (isAlreadyAdded) ...[
                              SizedBox(width: 1.5.w),
                              Icon(
                                Icons.check_rounded,
                                color: AppColors.primary,
                                size: 14.sp,
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectTime(bool isOpenTime) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isOpenTime
          ? const TimeOfDay(hour: 10, minute: 0)
          : const TimeOfDay(hour: 22, minute: 0),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFD9A24F),
              onPrimary: Color(0xFF11110F),
              surface: Color(0xFF1C1C1A),
              onSurface: Color(0xFFFFF1D2),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
      final formatted = '$hour:$minute $period';

      if (isOpenTime) {
        _openTimeController.text = formatted;
        ref.read(editProfileProvider.notifier).updateOpenTime(formatted);
      } else {
        _closeTimeController.text = formatted;
        ref.read(editProfileProvider.notifier).updateCloseTime(formatted);
      }
    }
  }

  Widget _buildFieldWrapper({
    required String label,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondaryDark,
            // fontSize: 11.5.sp,
          ),
        ),
        SizedBox(height: 0.8.h),
        child,
      ],
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.caption.copyWith(
        color: AppColors.textMutedDark,
      ),
      filled: true,
      fillColor: const Color(0xFF171715),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 1.5.h,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF262622)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF262622)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(editProfileProvider);
    final notifier = ref.read(editProfileProvider.notifier);
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
                          'Edit Profile',
                          style: AppTextStyles.headingWhite.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.creamText,
                          ),
                        ),
                        Text(
                          'Update public and billing details',
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
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _showImagePickerModal,
                      child: Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF171715),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1.8,
                          ),
                        ),
                        child: ClipOval(
                          child: model.avatarImagePath != null
                              ? Image.file(
                                  File(model.avatarImagePath!),
                                  width: 20.w,
                                  height: 20.w,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Icon(
                                    Icons.image_outlined,
                                    color: AppColors.primary,
                                    size: 20.sp,
                                  ),
                                )
                              : Center(
                                  child: Icon(
                                    Icons.image_outlined,
                                    color: AppColors.primary,
                                    size: 20.sp,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.2.h),
                    GestureDetector(
                      onTap: _showImagePickerModal,
                      child: Text(
                        'Change Photo',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),
              _buildFieldWrapper(
                label: 'Kitchen Name',
                child: TextField(
                  controller: _nameController,
                  onChanged: (val) => notifier.updateKitchenName(val),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.creamText,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: _inputDecoration(),
                ),
              ),
              SizedBox(height: 2.h),
              _buildFieldWrapper(
                label: 'Description / Bio',
                child: TextField(
                  controller: _bioController,
                  maxLines: 3,
                  onChanged: (val) => notifier.updateBio(val),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.creamText,
                    height: 1.4,
                  ),
                  decoration: _inputDecoration(),
                ),
              ),
              SizedBox(height: 2.h),
              _buildFieldWrapper(
                label: 'Cuisines (Multi-select)',
                child: Wrap(
                  spacing: 2.5.w,
                  runSpacing: 1.h,
                  children: [
                    ...model.cuisines.map((cuisine) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.5.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1C),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFF262622),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              cuisine,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.creamText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 1.5.w),
                            GestureDetector(
                              onTap: () => notifier.removeCuisine(cuisine),
                              child: Icon(
                                Icons.close_rounded,
                                color: AppColors.textSecondaryDark,
                                size: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    GestureDetector(
                      onTap: _showAddCuisineModal,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.5.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1.2,
                          ),
                        ),
                        child: Text(
                          '+ Add',
                          style: AppTextStyles.caption.copyWith(
                            // fontSize: 11.5.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                    child: _buildFieldWrapper(
                      label: 'Open Time',
                      child: GestureDetector(
                        onTap: () => _selectTime(true),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: _openTimeController,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.creamText,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: _inputDecoration(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: _buildFieldWrapper(
                      label: 'Close Time',
                      child: GestureDetector(
                        onTap: () => _selectTime(false),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: _closeTimeController,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.creamText,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: _inputDecoration(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                    child: _buildFieldWrapper(
                      label: 'Min Order Value',
                      child: TextField(
                        controller: _minOrderController,
                        onChanged: (val) => notifier.updateMinOrderValue(val),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.creamText,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: _inputDecoration(),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: _buildFieldWrapper(
                      label: 'Prep Time (mins)',
                      child: TextField(
                        controller: _prepTimeController,
                        onChanged: (val) => notifier.updatePrepTime(val),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.creamText,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: _inputDecoration(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              _buildFieldWrapper(
                label: 'Phone Number (Non-editable)',
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(text: model.phoneNumber),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textMutedDark,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: _inputDecoration(),
                ),
              ),
              SizedBox(height: 3.h),
              GestureDetector(
                onTap: () async {
                  notifier.updateKitchenName(_nameController.text);
                  notifier.updateBio(_bioController.text);
                  notifier.updateMinOrderValue(_minOrderController.text);
                  notifier.updatePrepTime(_prepTimeController.text);
                  await notifier.saveChanges();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profile updated successfully!'),
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
