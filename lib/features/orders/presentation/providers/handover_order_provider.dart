import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/handover_order_model.dart';
import '../../data/models/orders_page_model.dart';

class HandoverOrderState {
  const HandoverOrderState({
    required this.order,
  });

  final HandoverOrderModel order;

  HandoverOrderState copyWith({
    HandoverOrderModel? order,
  }) {
    return HandoverOrderState(
      order: order ?? this.order,
    );
  }
}

class HandoverOrderNotifier extends Notifier<HandoverOrderState> {
  @override
  HandoverOrderState build() {
    return const HandoverOrderState(
      order: HandoverOrderModel.dummy,
    );
  }

  void initializeForOrder(OrderItemDetail orderDetail, {String partnerName = 'Sumit Singh'}) {
    state = HandoverOrderState(
      order: HandoverOrderModel(
        orderId: orderDetail.id,
        orderNumber: orderDetail.orderNumber,
        statusSteps: const ['Accepted', 'Preparing', 'Ready', 'Picked Up'],
        currentStepIndex: 3,
        title: 'Handed Over Successfully',
        description:
            'Order has been collected by $partnerName. Customer will receive it in ~30 min.',
        partnerName: partnerName,
        partnerVehicleNo: 'DL 3S AQ 4528',
        partnerPhone: '+91 98765 43210',
      ),
    );
  }
}

final handoverOrderProvider =
    NotifierProvider<HandoverOrderNotifier, HandoverOrderState>(
  HandoverOrderNotifier.new,
);
