import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/tiffin_deliveries_provider.dart';

class TiffinDeliveriesScreen extends ConsumerWidget {
  const TiffinDeliveriesScreen({super.key});

  Future<void> _selectDate(
      BuildContext context, WidgetRef ref, String currentDate) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              onPrimary: Color(0xFF11110F),
              surface: Color(0xFF1C1C1A),
              onSurface: AppColors.creamText,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: Color(0xFF171715),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      final formatted =
          '${picked.day} ${months[picked.month - 1]} ${picked.year}';
      ref.read(tiffinDeliveriesProvider.notifier).updateDate(formatted);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tiffinDeliveriesProvider);
    final notifier = ref.read(tiffinDeliveriesProvider.notifier);
    final model = state.model;
    final deliveries = state.filteredDeliveries;
    final progress =
        (model.packedCount / (model.totalCount > 0 ? model.totalCount : 1))
            .clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
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
                    SizedBox(height: 2.5.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.5.h,
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
                          Row(
                            children: [
                              Text('📅', style: TextStyle(fontSize: 13.sp)),
                              SizedBox(width: 2.w),
                              Text(
                                state.selectedDate,
                                style: AppTextStyles.bodyWhite.copyWith(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.creamText,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => _selectDate(
                                context, ref, state.selectedDate),
                            child: Text(
                              'Change Date',
                              style: AppTextStyles.captionMedium.copyWith(
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF171715),
                        borderRadius: BorderRadius.circular(14),
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
                              Text(
                                'Packing Progress',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 12.5.sp,
                                  color: AppColors.textSecondaryDark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${model.packedCount} / ${model.totalCount} packed',
                                style: AppTextStyles.bodyWhite.copyWith(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.creamText,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.5.h),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 0.8.h,
                              backgroundColor: const Color(0xFF242420),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
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
                          child: GestureDetector(
                            onTap: () => notifier.selectMealType('Lunch'),
                            child: Container(
                              height: 5.6.h,
                              decoration: BoxDecoration(
                                color: state.selectedMealType == 'Lunch'
                                    ? AppColors.primary
                                    : const Color(0xFF171715),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: state.selectedMealType == 'Lunch'
                                      ? AppColors.primary
                                      : const Color(0xFF262622),
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Lunch (${model.lunchCount})',
                                  style: AppTextStyles.buttonMedium.copyWith(
                                    fontSize: 13.5.sp,
                                    fontWeight: FontWeight.w800,
                                    color: state.selectedMealType == 'Lunch'
                                        ? const Color(0xFF11110F)
                                        : AppColors.creamText,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 3.5.w),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => notifier.selectMealType('Dinner'),
                            child: Container(
                              height: 5.6.h,
                              decoration: BoxDecoration(
                                color: state.selectedMealType == 'Dinner'
                                    ? AppColors.primary
                                    : const Color(0xFF171715),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: state.selectedMealType == 'Dinner'
                                      ? AppColors.primary
                                      : const Color(0xFF262622),
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Dinner (${model.dinnerCount})',
                                  style: AppTextStyles.buttonMedium.copyWith(
                                    fontSize: 13.5.sp,
                                    fontWeight: FontWeight.w800,
                                    color: state.selectedMealType == 'Dinner'
                                        ? const Color(0xFF11110F)
                                        : AppColors.creamText,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.2.h),
                    ...deliveries.map((item) {
                      final isOutOfDelivery =
                          item.status == 'OUT FOR DELIVERY';
                      final badgeColor = isOutOfDelivery
                          ? const Color(0xFFFF9800)
                          : const Color(0xFF4CAF50);
                      final badgeBg = isOutOfDelivery
                          ? const Color(0xFF2B2215)
                          : const Color(0xFF142918);

                      return GestureDetector(
                        onTap: () {
                          context.push(AppRoutes.subscriberCard, extra: item);
                        },
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 1.5.h),
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF171715),
                            borderRadius: BorderRadius.circular(16),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.customerName,
                                    style: AppTextStyles.headingWhite.copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.creamText,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 2.5.w,
                                      vertical: 0.5.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: badgeBg,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      item.status,
                                      style: AppTextStyles.caption.copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w800,
                                        color: badgeColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.2.h),
                              Row(
                                children: [
                                  Text('🍱', style: TextStyle(fontSize: 11.5.sp)),
                                  SizedBox(width: 1.5.w),
                                  Text(
                                    'Items: ',
                                    style: AppTextStyles.caption.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColors.textSecondaryDark,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      item.itemsText,
                                      style: AppTextStyles.bodyWhite.copyWith(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.creamText,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 0.6.h),
                              Row(
                                children: [
                                  Text('🕒', style: TextStyle(fontSize: 11.5.sp)),
                                  SizedBox(width: 1.5.w),
                                  Text(
                                    'Slot: ',
                                    style: AppTextStyles.caption.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColors.textSecondaryDark,
                                    ),
                                  ),
                                  Text(
                                    item.slotText,
                                    style: AppTextStyles.bodyWhite.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.creamText,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 2.h),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 6.h,
                      child: ElevatedButton(
                        onPressed: () {
                          notifier.markAllPacked();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('All meals marked as packed!'),
                              backgroundColor: AppColors.success,
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1F1F1D),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: const BorderSide(
                              color: Color(0xFF2E2E2A),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Text(
                          'Mark All Packed',
                          style: AppTextStyles.buttonMedium.copyWith(
                            fontSize: 13.5.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.creamText,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.5.w),
                  Expanded(
                    child: SizedBox(
                      height: 6.h,
                      child: ElevatedButton(
                        onPressed: () {
                          context.push(
                            AppRoutes.assignPartner,
                            extra: 'TIFFIN-TODAY',
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          'Assign Partners',
                          style: AppTextStyles.buttonMedium.copyWith(
                            fontSize: 13.5.sp,
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
          ],
        ),
      ),
    );
  }
}
