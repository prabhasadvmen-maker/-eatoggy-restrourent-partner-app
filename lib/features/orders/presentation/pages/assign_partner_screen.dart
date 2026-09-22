import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/assign_partner_provider.dart';
import '../providers/orders_page_provider.dart';

class AssignPartnerScreen extends ConsumerWidget {
  const AssignPartnerScreen({
    super.key,
    required this.orderId,
  });

  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(assignPartnerProvider);
    final notifier = ref.read(assignPartnerProvider.notifier);
    final partners = state.filteredPartners;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.primary,
            size: 20,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          state.model.title,
          style: AppTextStyles.title.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.creamText,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 6.h,
              decoration: BoxDecoration(
                color: const Color(0xFF171715),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF262622), width: 1),
              ),
              child: TextField(
                onChanged: notifier.updateSearch,
                style: AppTextStyles.bodyWhite.copyWith(
                  fontSize: 13.5.sp,
                  color: AppColors.creamText,
                ),
                decoration: InputDecoration(
                  hintText: state.model.searchHint,
                  hintStyle: AppTextStyles.caption.copyWith(
                    fontSize: 13.sp,
                    color: AppColors.textMuted,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: AppColors.textMuted,
                    size: 18.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 1.4.h),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              state.model.sectionHeader,
              style: AppTextStyles.bodyWhite.copyWith(
                fontSize: 14.5.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.creamText,
              ),
            ),
            SizedBox(height: 2.h),
            ...partners.map(
              (partner) {
                final isSelected = state.selectedPartnerId == partner.id;
                return Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF171715),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : const Color(0xFF262622),
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 13.w,
                          height: 13.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFF242422),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 3.5.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                partner.name,
                                style: AppTextStyles.bodyWhite.copyWith(
                                  fontSize: 14.5.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.creamText,
                                ),
                              ),
                              SizedBox(height: 0.6.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_border_rounded,
                                    color: AppColors.primary,
                                    size: 14.sp,
                                  ),
                                  SizedBox(width: 1.w),
                                  Text(
                                    '${partner.rating} • ${partner.distance}',
                                    style: AppTextStyles.caption.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColors.textSecondaryDark,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.5.w,
                                vertical: 0.4.h,
                              ),
                              decoration: BoxDecoration(
                                color: partner.isAvailable
                                    ? const Color(0xFF16291C)
                                    : const Color(0xFF2E2214),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                partner.status,
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 10.5.sp,
                                  fontWeight: FontWeight.w700,
                                  color: partner.isAvailable
                                      ? const Color(0xFF4CAF50)
                                      : const Color(0xFFFF9800),
                                ),
                              ),
                            ),
                            SizedBox(height: 1.2.h),
                            SizedBox(
                              height: 4.8.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  notifier.selectPartner(partner.id);
                                  ref.read(ordersPageProvider.notifier).markCompleted(orderId);
                                  context.pushReplacement(
                                    AppRoutes.handoverOrder,
                                    extra: orderId,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.zero,
                                  backgroundColor: isSelected
                                      ? AppColors.primary
                                      : const Color(0xFF1F1F1D),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: isSelected
                                          ? AppColors.primary
                                          : const Color(0xFF33332E),
                                      width: 1,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                  ),
                                ),
                                child: Text(
                                  'Assign',
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
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
