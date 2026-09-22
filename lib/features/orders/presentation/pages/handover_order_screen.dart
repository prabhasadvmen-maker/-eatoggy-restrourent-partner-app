import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/orders_page_provider.dart';
import '../providers/handover_order_provider.dart';

class HandoverOrderScreen extends ConsumerStatefulWidget {
  const HandoverOrderScreen({
    super.key,
    required this.orderId,
  });

  final String orderId;

  @override
  ConsumerState<HandoverOrderScreen> createState() =>
      _HandoverOrderScreenState();
}

class _HandoverOrderScreenState extends ConsumerState<HandoverOrderScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orders = ref.read(ordersPageProvider).ordersList;
      final matching = orders.firstWhere(
        (o) => o.id == widget.orderId || o.orderNumber == widget.orderId,
        orElse: () => ref.read(ordersPageProvider).ordersList.first,
      );
      ref.read(handoverOrderProvider.notifier).initializeForOrder(matching);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(handoverOrderProvider);
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildStepItem(label: 'Accepted', isDone: true, isActive: false),
                  _buildStepConnector(isDone: true),
                  _buildStepItem(label: 'Preparing', isDone: true, isActive: false),
                  _buildStepConnector(isDone: true),
                  _buildStepItem(label: 'Ready', isDone: true, isActive: false),
                  _buildStepConnector(isDone: true),
                  _buildStepItem(label: 'Picked Up', isDone: true, isActive: true),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            Container(
              width: 22.w,
              height: 22.w,
              decoration: const BoxDecoration(
                color: Color(0xFF132A1C),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.check_rounded,
                  color: Color(0xFF388E3C),
                  size: 28.sp,
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              order.title,
              textAlign: TextAlign.center,
              style: AppTextStyles.headingWhite.copyWith(
                fontSize: 19.sp,
                fontWeight: FontWeight.w900,
                color: AppColors.creamText,
              ),
            ),
            SizedBox(height: 1.2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                order.description,
                textAlign: TextAlign.center,
                style: AppTextStyles.caption.copyWith(
                  fontSize: 12.5.sp,
                  color: AppColors.textSecondaryDark,
                  height: 1.4,
                ),
              ),
            ),
            SizedBox(height: 4.h),
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
                    'Delivery Partner Details',
                    style: AppTextStyles.bodyWhite.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.creamText,
                    ),
                  ),
                  SizedBox(height: 1.8.h),
                  Row(
                    children: [
                      Container(
                        width: 12.w,
                        height: 12.w,
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
                              order.partnerName,
                              style: AppTextStyles.bodyWhite.copyWith(
                                fontSize: 14.5.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.creamText,
                              ),
                            ),
                            SizedBox(height: 0.4.h),
                            Text(
                              order.partnerVehicleNo,
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 12.sp,
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
                            size: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            SizedBox(
              width: double.infinity,
              height: 6.h,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(ordersPageProvider.notifier).markCompleted(order.orderId);
                  context.go(AppRoutes.dashboard);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Done',
                  style: AppTextStyles.buttonMedium.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF11110F),
                  ),
                ),
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
    return Row(
      children: [
        Container(
          width: 5.w,
          height: 5.w,
          decoration: BoxDecoration(
            color: const Color(0xFF388E3C),
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF388E3C),
              width: 1.5,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.check_rounded,
              size: 13.sp,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(width: 1.8.w),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w700,
            color: isActive ? AppColors.primary : const Color(0xFF388E3C),
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
      color: const Color(0xFF388E3C),
    );
  }
}
