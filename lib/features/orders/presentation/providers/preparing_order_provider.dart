import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/preparing_order_model.dart';
import '../../data/models/orders_page_model.dart';

class PreparingOrderState {
  const PreparingOrderState({
    required this.order,
    this.remainingSeconds = 1500,
  });

  final PreparingOrderModel order;
  final int remainingSeconds;

  String get formattedTime {
    final minutes = (remainingSeconds / 60).floor();
    final seconds = remainingSeconds % 60;
    final minStr = minutes.toString().padLeft(2, '0');
    final secStr = seconds.toString().padLeft(2, '0');
    return '$minStr:$secStr';
  }

  PreparingOrderState copyWith({
    PreparingOrderModel? order,
    int? remainingSeconds,
  }) {
    return PreparingOrderState(
      order: order ?? this.order,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
    );
  }
}

class PreparingOrderNotifier extends Notifier<PreparingOrderState> {
  Timer? _timer;

  @override
  PreparingOrderState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return const PreparingOrderState(
      order: PreparingOrderModel.dummy,
      remainingSeconds: 1500,
    );
  }

  void initializeForOrder(OrderItemDetail orderDetail, {int initialMinutes = 25}) {
    _timer?.cancel();

    final checklist = orderDetail.itemsList.asMap().entries.map((entry) {
      return PreparationCheckItem(
        id: '${entry.key}',
        title: entry.value,
        isDone: entry.key < 2,
      );
    }).toList();

    final totalSecs = initialMinutes * 60;

    state = PreparingOrderState(
      remainingSeconds: totalSecs,
      order: PreparingOrderModel(
        orderId: orderDetail.id,
        orderNumber: orderDetail.orderNumber,
        statusSteps: const ['Accepted', 'Preparing', 'Ready', 'Picked Up'],
        currentStepIndex: 1,
        remainingTime: '${initialMinutes.toString().padLeft(2, '0')}:00',
        acceptingMoreOrdersText: 'Accepting more order requests',
        checklist: checklist.isEmpty
            ? PreparingOrderModel.dummy.checklist
            : checklist,
        customerPhone: '+91 98765 43210',
        deliveryPartnerPhone: '+91 91234 56789',
      ),
    );

    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds > 0) {
        state = state.copyWith(
          remainingSeconds: state.remainingSeconds - 1,
        );
      } else {
        timer.cancel();
      }
    });
  }

  void toggleItemCheck(String id) {
    final updatedChecklist = state.order.checklist.map((item) {
      if (item.id == id) {
        return item.copyWith(isDone: !item.isDone);
      }
      return item;
    }).toList();

    state = state.copyWith(
      order: PreparingOrderModel(
        orderId: state.order.orderId,
        orderNumber: state.order.orderNumber,
        statusSteps: state.order.statusSteps,
        currentStepIndex: state.order.currentStepIndex,
        remainingTime: state.order.remainingTime,
        acceptingMoreOrdersText: state.order.acceptingMoreOrdersText,
        checklist: updatedChecklist,
        customerPhone: state.order.customerPhone,
        deliveryPartnerPhone: state.order.deliveryPartnerPhone,
      ),
    );
  }
}

final preparingOrderProvider =
    NotifierProvider<PreparingOrderNotifier, PreparingOrderState>(
  PreparingOrderNotifier.new,
);

