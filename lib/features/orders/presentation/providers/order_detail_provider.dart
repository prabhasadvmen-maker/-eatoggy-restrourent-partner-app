import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/order_detail_model.dart';
import '../../data/models/orders_page_model.dart';
import 'orders_page_provider.dart';

class OrderDetailState {
  const OrderDetailState({
    required this.orderDetail,
    this.selectedPrepTime = 25,
  });

  final OrderDetailModel orderDetail;
  final int selectedPrepTime;

  OrderDetailState copyWith({
    OrderDetailModel? orderDetail,
    int? selectedPrepTime,
  }) {
    return OrderDetailState(
      orderDetail: orderDetail ?? this.orderDetail,
      selectedPrepTime: selectedPrepTime ?? this.selectedPrepTime,
    );
  }
}

class OrderPrepTimeNotifier extends Notifier<Map<String, int>> {
  @override
  Map<String, int> build() => {};

  void setPrepTime(String orderId, int minutes) {
    state = {...state, orderId: minutes};
  }
}

final orderPrepTimeProvider = NotifierProvider<OrderPrepTimeNotifier, Map<String, int>>(
  OrderPrepTimeNotifier.new,
);

final orderDetailProvider = Provider.family<OrderDetailState, String>((ref, orderId) {
  final parentOrders = ref.watch(ordersPageProvider).ordersList;
  final prepTimes = ref.watch(orderPrepTimeProvider);
  final selectedPrepTime = prepTimes[orderId] ?? 25;

  final OrderItemDetail matchingOrder = parentOrders.firstWhere(
    (o) => o.id == orderId || o.orderNumber == orderId,
    orElse: () => const OrderItemDetail(
      id: '1',
      orderNumber: 'EAT1234',
      timeAgo: '5 min ago',
      amount: '₹650',
      customerName: 'Rahul Sharma',
      itemsList: ['2x Butter Chicken', '1x Naan', '1x Dal Makhani'],
      status: 'New',
    ),
  );

  final detail = OrderDetailModel(
    id: matchingOrder.id,
    orderNumber: matchingOrder.orderNumber,
    status: matchingOrder.status == 'New' ? 'New Order' : matchingOrder.status,
    customerName: matchingOrder.customerName,
    customerAddress: 'Flat 402, Royal Residency, Sector 5',
    customerPhone: '+919876543210',
    items: const [
      OrderItem(qty: '2x', title: 'Butter Chicken', subtitle: 'Extra spicy', price: '₹440'),
      OrderItem(qty: '1x', title: 'Naan', subtitle: 'With butter', price: '₹60'),
      OrderItem(qty: '1x', title: 'Dal Makhani', subtitle: 'No onion, no garlic', price: '₹150'),
    ],
    itemTotal: matchingOrder.amount,
    gst: '₹32.50',
    packagingCharges: '₹40',
    deliveryFee: '₹27.50',
    grandTotal: matchingOrder.amount,
  );

  return OrderDetailState(
    orderDetail: detail,
    selectedPrepTime: selectedPrepTime,
  );
});
