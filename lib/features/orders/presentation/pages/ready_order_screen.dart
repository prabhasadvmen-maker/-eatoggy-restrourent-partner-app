import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/orders_page_provider.dart';
import '../providers/ready_order_provider.dart';

class ReadyOrderScreen extends ConsumerStatefulWidget {
  const ReadyOrderScreen({
    super.key,
    required this.orderId,
  });

  final String orderId;

  @override
  ConsumerState<ReadyOrderScreen> createState() => _ReadyOrderScreenState();
}

class _ReadyOrderScreenState extends ConsumerState<ReadyOrderScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orders = ref.read(ordersPageProvider).ordersList;
      final matching = orders.firstWhere(
        (o) => o.id == widget.orderId || o.orderNumber == widget.orderId,
        orElse: () => ref.read(ordersPageProvider).ordersList.first,
      );
      ref.read(readyOrderProvider.notifier).initializeForOrder(matching);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(readyOrderProvider);
    final order = state.order;

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
          'Order #${order.orderNumber}',
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildStepItem(
                    label: 'Accepted',
                    isDone: true,
                    isActive: false,
                  ),
                  _buildStepConnector(isDone: true),
                  _buildStepItem(
                    label: 'Preparing',
                    isDone: true,
                    isActive: false,
                  ),
                  _buildStepConnector(isDone: true),
                  _buildStepItem(
                    label: 'Ready',
                    isDone: true,
                    isActive: true,
                  ),
                  _buildStepConnector(isDone: false),
                  _buildStepItem(
                    label: 'Picked Up',
                    isDone: false,
                    isActive: false,
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.5.w),
              decoration: BoxDecoration(
                color: const Color(0xFF142419),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF2E7D32),
                  width: 1.2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 7.w,
                    height: 7.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF4CAF50),
                        width: 1.8,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check_rounded,
                        size: 14.sp,
                        color: const Color(0xFF4CAF50),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.5.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.handoverTitle,
                          style: AppTextStyles.bodyWhite.copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF4CAF50),
                          ),
                        ),
                        SizedBox(height: 0.4.h),
                        Text(
                          order.handoverSubtitle,
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xFFB0BEC5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),
            SizedBox(
              width: double.infinity,
              height: 6.h,
              child: ElevatedButton(
                onPressed: () {
                  context.push(AppRoutes.assignPartner, extra: order.orderId);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Assign Partner',
                  style: AppTextStyles.buttonMedium.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF11110F),
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.8.h),
            SizedBox(
              width: double.infinity,
              height: 5.8.h,
              child: OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Calling customer ${order.customerPhone}...'),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFF171715),
                  side: const BorderSide(
                    color: Color(0xFF262622),
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Call Customer',
                  style: AppTextStyles.buttonMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.creamText,
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.5.w),
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
                  Text(
                    'Order Summary',
                    style: AppTextStyles.bodyWhite.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.creamText,
                    ),
                  ),
                  SizedBox(height: 1.2.h),
                  Text(
                    '${order.customerName} • ${order.itemCountText} • ${order.amount}',
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.textSecondaryDark,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem({
    required String label,
    required bool isDone,
    required bool isActive,
  }) {
    Color itemColor;
    if (isDone || isActive) {
      itemColor = AppColors.primary;
    } else {
      itemColor = AppColors.textMuted;
    }

    return Row(
      children: [
        Container(
          width: 5.w,
          height: 5.w,
          decoration: BoxDecoration(
            color: isDone ? const Color(0xFF388E3C) : const Color(0xFF262622),
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive
                  ? AppColors.primary
                  : (isDone ? const Color(0xFF388E3C) : const Color(0xFF3E3E3A)),
              width: 1.5,
            ),
          ),
          child: Center(
            child: isDone
                ? Icon(
                    Icons.check_rounded,
                    size: 13.sp,
                    color: Colors.black,
                  )
                : Container(
                    width: 1.8.w,
                    height: 1.8.w,
                    decoration: BoxDecoration(
                      color: itemColor,
                      shape: BoxShape.circle,
                    ),
                  ),
          ),
        ),
        SizedBox(width: 1.8.w),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            fontWeight: isDone || isActive ? FontWeight.w700 : FontWeight.w500,
            color: isDone
                ? (isActive ? AppColors.primary : const Color(0xFF388E3C))
                : (isActive ? AppColors.primary : AppColors.textMuted),
          ),
        ),
      ],
    );
  }

  Widget _buildStepConnector({required bool isDone}) {
    return Container(
      width: 6.w,
      height: 1.5,
      margin: EdgeInsets.symmetric(horizontal: 1.8.w),
      color: isDone ? const Color(0xFF388E3C) : const Color(0xFF2A2A26),
    );
  }
}
