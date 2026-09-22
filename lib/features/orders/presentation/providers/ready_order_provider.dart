import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/ready_order_model.dart';
import '../../data/models/orders_page_model.dart';

class ReadyOrderState {
  const ReadyOrderState({
    required this.order,
  });

  final ReadyOrderModel order;

  ReadyOrderState copyWith({
    ReadyOrderModel? order,
  }) {
    return ReadyOrderState(
      order: order ?? this.order,
    );
  }
}

class ReadyOrderNotifier extends Notifier<ReadyOrderState> {
  @override
  ReadyOrderState build() {
    return const ReadyOrderState(
      order: ReadyOrderModel.dummy,
    );
  }

  void initializeForOrder(OrderItemDetail orderDetail) {
    state = ReadyOrderState(
      order: ReadyOrderModel(
        orderId: orderDetail.id,
        orderNumber: orderDetail.orderNumber,
        statusSteps: const ['Accepted', 'Preparing', 'Ready', 'Picked Up'],
        currentStepIndex: 2,
        handoverTitle: 'Order Ready for Handover',
        handoverSubtitle: 'Waiting for delivery partner to arrive',
        customerName: orderDetail.customerName,
        itemCountText: '${orderDetail.itemsList.length} items',
        amount: orderDetail.amount,
        customerPhone: '+91 98765 43210',
      ),
    );
  }
}

final readyOrderProvider =
    NotifierProvider<ReadyOrderNotifier, ReadyOrderState>(
  ReadyOrderNotifier.new,
);
