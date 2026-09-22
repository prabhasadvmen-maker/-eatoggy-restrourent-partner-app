import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/order_detail_provider.dart';
import '../providers/orders_page_provider.dart';

class OrderDetailScreen extends ConsumerWidget {
  const OrderDetailScreen({
    super.key,
    required this.orderId,
  });

  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(orderDetailProvider(orderId));
    final model = detailState.orderDetail;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.primary, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Order #${model.orderNumber}',
          style: AppTextStyles.title.copyWith(
            fontSize: 19.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 1.5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(4.5.w),
              decoration: BoxDecoration(
                color: const Color(0xFF171715),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF262622), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'STATUS',
                        style: AppTextStyles.caption.copyWith(
                          // fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                          color: AppColors.textMuted,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.6.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF262117),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          model.status,
                          style: AppTextStyles.caption.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.8.h),
                  Divider(color: const Color(0xFF242420), height: 1),
                  SizedBox(height: 1.8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.customerName,
                              style: AppTextStyles.bodyWhite.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.creamText,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              model.customerAddress,
                              style: AppTextStyles.caption.copyWith(
                                // fontSize: 12.sp,
                                color: AppColors.textSecondaryDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 11.w,
                        height: 11.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF24211A),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.phone_in_talk_rounded,
                            color: AppColors.primary,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.8.h),
            Text(
              'Select Preparation Time',
              style: AppTextStyles.bodyWhite.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.creamText,
              ),
            ),
            SizedBox(height: 1.5.h),
            Row(
              children: model.prepTimeOptions.map((time) {
                final isSelected = detailState.selectedPrepTime == time;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    child: GestureDetector(
                      onTap: () {
                        ref
                            .read(orderPrepTimeProvider.notifier)
                            .setPrepTime(orderId, time);
                      },
                      child: Container(
                        height: 5.5.h,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : const Color(0xFF171715),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : const Color(0xFF262622),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '$time min',
                            style: AppTextStyles.buttonMedium.copyWith(
                              fontWeight: FontWeight.w700,
                              color: isSelected ? const Color(0xFF11110F) : AppColors.creamText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 2.8.h),
            Container(
              padding: EdgeInsets.all(4.5.w),
              decoration: BoxDecoration(
                color: const Color(0xFF171715),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF262622), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Items List',
                    style: AppTextStyles.bodyWhite.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.creamText,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  ...model.items.map(
                    (item) => Padding(
                      padding: EdgeInsets.only(bottom: 1.8.h),
                      child: _buildItemRow(
                        qty: item.qty,
                        title: item.title,
                        subtitle: item.subtitle,
                        price: item.price,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.8.h),
            Container(
              padding: EdgeInsets.all(4.5.w),
              decoration: BoxDecoration(
                color: const Color(0xFF171715),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF262622), width: 1),
              ),
              child: Column(
                children: [
                  _buildBillRow('Item Total', model.itemTotal),
                  SizedBox(height: 1.4.h),
                  _buildBillRow('GST (5%)', model.gst),
                  SizedBox(height: 1.4.h),
                  _buildBillRow('Packaging charges', model.packagingCharges),
                  SizedBox(height: 1.4.h),
                  _buildBillRow('Delivery Partner Fee', model.deliveryFee),
                  SizedBox(height: 2.h),
                  Divider(color: const Color(0xFF242420), height: 1),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Grand Total',
                        style: AppTextStyles.bodyWhite.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.creamText,
                        ),
                      ),
                      Text(
                        model.grandTotal,
                        style: AppTextStyles.bodyWhite.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.2.h),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 6.2.h,
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(ordersPageProvider.notifier).rejectOrder(model.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Order Rejected')),
                        );
                        context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE25C57),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'Reject Order',
                        style: AppTextStyles.buttonMedium.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 3.5.w),
                Expanded(
                  child: SizedBox(
                    height: 6.2.h,
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(ordersPageProvider.notifier).acceptOrder(model.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Order Accepted successfully!')),
                        );
                        context.pushReplacement(AppRoutes.preparingOrder, extra: model.id);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'Accept Order',
                        style: AppTextStyles.buttonMedium.copyWith(
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF11110F),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow({
    required String qty,
    required String title,
    required String subtitle,
    required String price,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          qty,
          style: AppTextStyles.bodyWhite.copyWith(
            // fontSize: 14.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        SizedBox(width: 2.5.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyWhite.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.creamText,
                ),
              ),
              SizedBox(height: 0.3.h),
              Text(
                subtitle,
                style: AppTextStyles.caption.copyWith(
                  fontSize: 13.sp,
                  color: AppColors.textSecondaryDark,
                ),
              ),
            ],
          ),
        ),
        Text(
          price,
          style: AppTextStyles.bodyWhite.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondaryDark,
          ),
        ),
      ],
    );
  }

  Widget _buildBillRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            // fontSize: 13.sp,
            color: AppColors.textSecondaryDark,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.caption.copyWith(
            // fontSize: 1.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.creamText,
          ),
        ),
      ],
    );
  }
}
