import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/create_tiffin_plan_model.dart';
import '../providers/create_tiffin_plan_provider.dart';

class CreateTiffinPlanScreen extends ConsumerStatefulWidget {
  const CreateTiffinPlanScreen({super.key});

  @override
  ConsumerState<CreateTiffinPlanScreen> createState() =>
      _CreateTiffinPlanScreenState();
}

class _CreateTiffinPlanScreenState
    extends ConsumerState<CreateTiffinPlanScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _pricingController;
  late final TextEditingController _pincodesController;
  late final TextEditingController _subscriberCapController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    const defaultModel = CreateTiffinPlanModel.dummy;

    _nameController = TextEditingController(text: defaultModel.planName);
    _pricingController =
        TextEditingController(text: defaultModel.pricingPerCycle);
    _pincodesController =
        TextEditingController(text: defaultModel.serviceablePincodes);
    _subscriberCapController =
        TextEditingController(text: defaultModel.maxSubscriberCap);
    _descriptionController =
        TextEditingController(text: defaultModel.planDescription);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pricingController.dispose();
    _pincodesController.dispose();
    _subscriberCapController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onPublishPlan() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Tiffin Plan published successfully!',
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
    final state = ref.watch(createTiffinPlanProvider);
    final notifier = ref.read(createTiffinPlanProvider.notifier);
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
                      SizedBox(height: 3.h),
                      Text(
                        'Plan Name',
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
                            hintText: 'e.g. Office Special Lunch Plan',
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
                              return 'Please enter plan name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 2.2.h),
                      Text(
                        'Plan Cycle Type',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.creamText,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF171715),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF262622),
                            width: 1,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: state.selectedCycleType,
                            isExpanded: true,
                            dropdownColor: const Color(0xFF1C1C1A),
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColors.primary,
                              size: 18.sp,
                            ),
                            style: AppTextStyles.body.copyWith(
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.creamText,
                            ),
                            items: model.cycleOptions.map((opt) {
                              return DropdownMenuItem<String>(
                                value: opt,
                                child: Text(opt),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                notifier.selectCycleType(val);
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 2.2.h),
                      Text(
                        'Pricing per Cycle (₹)',
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
                          controller: _pricingController,
                          keyboardType: TextInputType.number,
                          style: AppTextStyles.body.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.creamText,
                          ),
                          decoration: InputDecoration(
                            hintText: 'e.g. 1499',
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
                              return 'Enter pricing';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 2.2.h),
                      Text(
                        'Number of Meals per Day',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.creamText,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: model.mealOptions.map((count) {
                          final isSelected = state.mealsPerDay == count;
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: count != model.mealOptions.last ? 3.w : 0,
                              ),
                              child: GestureDetector(
                                onTap: () => notifier.selectMealsPerDay(count),
                                child: Container(
                                  height: 5.6.h,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary
                                        : const Color(0xFF171715),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primary
                                          : const Color(0xFF262622),
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$count Meal${count > 1 ? 's' : ''}',
                                      style: AppTextStyles.buttonMedium.copyWith(
                                        fontSize: 13.5.sp,
                                        fontWeight: FontWeight.w800,
                                        color: isSelected
                                            ? const Color(0xFF11110F)
                                            : AppColors.creamText,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 2.2.h),
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
                                  'Rotating Weekly Menu',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontSize: 13.5.sp,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.creamText,
                                  ),
                                ),
                                SizedBox(height: 0.3.h),
                                Text(
                                  'Menu items change every day',
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
                                value: state.rotatingWeeklyMenu,
                                onChanged: (val) {
                                  notifier.toggleRotatingWeeklyMenu(val);
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
                      SizedBox(height: 2.2.h),
                      Text(
                        'Serviceable Pincodes',
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
                          controller: _pincodesController,
                          style: AppTextStyles.body.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.creamText,
                          ),
                          decoration: InputDecoration(
                            hintText: 'e.g. 380015, 380054 (Comma separated)',
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
                        ),
                      ),
                      SizedBox(height: 2.2.h),
                      Text(
                        'Max Subscriber Cap',
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
                          controller: _subscriberCapController,
                          keyboardType: TextInputType.number,
                          style: AppTextStyles.body.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.creamText,
                          ),
                          decoration: InputDecoration(
                            hintText: 'e.g. 50 (Leave blank for unlimited)',
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
                        ),
                      ),
                      SizedBox(height: 2.2.h),
                      Text(
                        'Plan Description',
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
                                'Give brief details about target audience, meal nutritional breakdown...',
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
                  onPressed: _onPublishPlan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Publish Tiffin Plan',
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
