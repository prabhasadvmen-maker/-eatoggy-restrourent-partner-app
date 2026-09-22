import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/orders_page_model.dart';
import '../providers/orders_page_provider.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ordersPageProvider);
    final notifier = ref.read(ordersPageProvider.notifier);
    final data = state.data;
    final ordersList = state.filteredOrders;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.title,
                    style: AppTextStyles.headingWhite.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                children: data.filterTabs.map((tab) {
                  final isSelected = state.activeFilter == tab.id;
                  return Padding(
                    padding: EdgeInsets.only(right: 2.5.w),
                    child: GestureDetector(
                      onTap: () => notifier.selectFilter(tab.id),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : null,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.darkBorder,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              tab.label,
                              style: AppTextStyles.bodyMedium.copyWith(
                                // fontSize: 13.sp,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: isSelected
                                    ? const Color(0xFF11110F)
                                    : AppColors.textSecondary,
                              ),
                            ),
                            if (tab.badgeCount > 0) ...[
                              SizedBox(width: 1.8.w),
                              Container(
                                width: 2.2.h,
                                height: 2.2.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF11110F)
                                      : AppColors.error,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${tab.badgeCount}',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.captionWhite.copyWith(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w700,
                                    // height: 1,
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 2.5.h),
            Expanded(
              child: ordersList.isEmpty
                  ? Center(
                      child: Text(
                        'No orders found',
                        style: AppTextStyles.bodySecondary.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      itemCount: ordersList.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 2.h),
                      itemBuilder: (context, index) {
                        final order = ordersList[index];
                        return _buildOrderCard(context, order, notifier);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(
    BuildContext context,
    OrderItemDetail order,
    OrdersPageNotifier notifier,
  ) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.orderDetail, extra: order.id),
      child: Container(
        padding: EdgeInsets.all(4.5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.darkBorder, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      order.orderNumber,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      '  •  ${order.timeAgo}',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondaryDark,
                      ),
                    ),
                  ],
                ),
                Text(
                  order.amount,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.5.h),
            Divider(color: AppColors.darkBorder, height: 1),
            SizedBox(height: 1.5.h),
            Text(
              order.customerName,
              style: AppTextStyles.bodyWhite.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 0.8.h),
            ...order.itemsList.map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 0.4.h),
                child: Text(
                  item,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 13.sp,
                    color: AppColors.textSecondaryDark,
                  ),
                ),
              ),
            ),
            if (order.status == 'New') ...[
              SizedBox(height: 2.2.h),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 5.2.h,
                      child: ElevatedButton(
                        onPressed: () => notifier.rejectOrder(order.id),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.darkSurface,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(
                              color: AppColors.darkBorder,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Text(
                          'Reject',
                          style: AppTextStyles.buttonMedium.copyWith(
                            // fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.5.w),
                  Expanded(
                    child: SizedBox(
                      height: 5.2.h,
                      child: ElevatedButton(
                        onPressed: () {
                          notifier.acceptOrder(order.id);
                          context.push(AppRoutes.orderDetail, extra: order.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Accept',
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
            ] else if (order.status == 'Preparing') ...[
              SizedBox(height: 2.2.h),
              SizedBox(
                width: double.infinity,
                height: 5.2.h,
                child: ElevatedButton(
                  onPressed: () => notifier.markReady(order.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Mark Ready',
                    style: AppTextStyles.buttonMedium.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF11110F),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
