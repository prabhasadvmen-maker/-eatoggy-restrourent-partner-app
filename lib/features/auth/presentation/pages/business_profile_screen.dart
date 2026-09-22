import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/business_profile_provider.dart';

class BusinessProfileScreen extends ConsumerStatefulWidget {
  const BusinessProfileScreen({super.key});

  @override
  ConsumerState<BusinessProfileScreen> createState() =>
      _BusinessProfileScreenState();
}

class _BusinessProfileScreenState
    extends ConsumerState<BusinessProfileScreen> {
  late final TextEditingController _restaurantNameController;
  late final TextEditingController _ownerNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(businessProfileProvider);

    _restaurantNameController =
        TextEditingController(text: state.restaurantName);
    _ownerNameController = TextEditingController(text: state.ownerName);
    _phoneController = TextEditingController(text: state.phone);
    _emailController = TextEditingController(text: state.email);
    _addressController = TextEditingController(text: state.address);
  }

  @override
  void dispose() {
    _restaurantNameController.dispose();
    _ownerNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _onContinue() {
    ref.read(businessProfileProvider.notifier).submitProfile(
      onSuccess: () {
        if (!mounted) return;
        context.push(AppRoutes.verifyDocuments);
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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(businessProfileProvider);
    final data = state.data;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),

              Row(
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
                          data.headerTitle,
                          style: AppTextStyles.subheadMedium.copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.goldFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    data.stepText,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.goldFont,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 1.2.h),

              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppColors.darkBorder,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: data.stepProgress,
                    child: Container(
                      height: 3,
                      decoration: BoxDecoration(
                        color: AppColors.goldFont,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 4.h),

              Text(
                data.title,
                style: AppTextStyles.title.copyWith(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),

              SizedBox(height: 3.h),

              _buildFieldLabel(data.restaurantNameLabel),
              SizedBox(height: 1.h),
              _buildInputField(
                controller: _restaurantNameController,
                hintText: data.dummyRestaurantName,
                onChanged: (val) => ref
                    .read(businessProfileProvider.notifier)
                    .updateRestaurantName(val),
              ),

              SizedBox(height: 2.5.h),

              _buildFieldLabel(data.ownerNameLabel),
              SizedBox(height: 1.h),
              _buildInputField(
                controller: _ownerNameController,
                hintText: data.dummyOwnerName,
                onChanged: (val) => ref
                    .read(businessProfileProvider.notifier)
                    .updateOwnerName(val),
              ),

              SizedBox(height: 2.5.h),

              _buildFieldLabel(data.businessTypeLabel),
              SizedBox(height: 1.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.darkBorder, width: 1),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: state.businessType,
                    isExpanded: true,
                    dropdownColor: AppColors.darkSurface,
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.goldFont,
                      size: 20.sp,
                    ),
                    items: data.businessTypeOptions.map((type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(
                          type,
                          style: AppTextStyles.bodySecondary.copyWith(
                            fontSize: 14.5.sp,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        ref
                            .read(businessProfileProvider.notifier)
                            .updateBusinessType(val);
                      }
                    },
                  ),
                ),
              ),

              SizedBox(height: 2.5.h),

              _buildFieldLabel(data.phoneLabel),
              SizedBox(height: 1.h),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.darkBorder, width: 1),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 4.w),
                    Text(
                      data.countryCode,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        cursorColor: AppColors.primary,
                        style: AppTextStyles.bodySecondary.copyWith(
                          fontSize: 14.5.sp,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        onChanged: (val) => ref
                            .read(businessProfileProvider.notifier)
                            .updatePhone(val),
                        decoration: InputDecoration(
                          filled: false,
                          fillColor: Colors.transparent,
                          hintText: data.dummyPhone,
                          hintStyle: AppTextStyles.hint,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 1.8.h),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 2.5.h),

              _buildFieldLabel(data.emailLabel),
              SizedBox(height: 1.h),
              _buildInputField(
                controller: _emailController,
                hintText: data.dummyEmail,
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) => ref
                    .read(businessProfileProvider.notifier)
                    .updateEmail(val),
              ),

              SizedBox(height: 2.5.h),

              _buildFieldLabel(data.addressLabel),
              SizedBox(height: 1.h),
              _buildInputField(
                controller: _addressController,
                hintText: data.dummyAddress,
                maxLines: 2,
                onChanged: (val) => ref
                    .read(businessProfileProvider.notifier)
                    .updateAddress(val),
              ),

              SizedBox(height: 4.h),

              SizedBox(
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

              SizedBox(height: 4.h),
            ],
          ),
        ),
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
    int maxLines = 1,
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
        maxLines: maxLines,
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
