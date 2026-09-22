import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderModel {
  const OrderModel({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.time,
    this.address = 'Sector 62, Noida, Uttar Pradesh',
    this.prepTime = '20 mins',
    this.instructions = 'Please make less spicy and send extra green chutney.',
  });

  final String id;
  final String customerName;
  final String customerPhone;
  final List<String> items;
  final String totalAmount;
  final String status;
  final String time;
  final String address;
  final String prepTime;
  final String instructions;

  OrderModel copyWith({
    String? id,
    String? customerName,
    String? customerPhone,
    List<String>? items,
    String? totalAmount,
    String? status,
    String? time,
    String? address,
    String? prepTime,
    String? instructions,
  }) {
    return OrderModel(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      time: time ?? this.time,
      address: address ?? this.address,
      prepTime: prepTime ?? this.prepTime,
      instructions: instructions ?? this.instructions,
    );
  }
}

class OrdersNotifier extends Notifier<List<OrderModel>> {
  @override
  List<OrderModel> build() {
    return [
      const OrderModel(
        id: '1048',
        customerName: 'Rahul Sharma',
        customerPhone: '+91 98765 43210',
        items: ['2x Paneer Butter Masala', '4x Butter Naan', '1x Jeera Rice'],
        totalAmount: '₹580',
        status: 'New',
        time: 'Just now',
        address: 'Flat 402, Sunshine Heights, Sector 62, Noida',
        instructions: 'Please make the Paneer curry less spicy. Send extra green mint chutney.',
      ),
      const OrderModel(
        id: '1047',
        customerName: 'Priya Verma',
        customerPhone: '+91 98112 33445',
        items: ['1x Chicken Biryani (Special)', '2x Gulab Jamun'],
        totalAmount: '₹390',
        status: 'New',
        time: '3 mins ago',
        address: 'Tower B, Express Zenith, Sector 77, Noida',
      ),
      const OrderModel(
        id: '1046',
        customerName: 'Amit Patel',
        customerPhone: '+91 97234 56789',
        items: ['1x Dal Makhani', '2x Garlic Naan', '1x Veg Pulao'],
        totalAmount: '₹420',
        status: 'Preparing',
        time: '12 mins ago',
        address: 'Villa 12, Stellar Park, Greater Noida',
      ),
      const OrderModel(
        id: '1045',
        customerName: 'Sneha Rao',
        customerPhone: '+91 99887 76655',
        items: ['2x Veg Hakka Noodles', '1x Chilli Paneer Dry'],
        totalAmount: '₹460',
        status: 'Preparing',
        time: '18 mins ago',
        address: 'A-304, Prateek Edifice, Sector 107, Noida',
      ),
      const OrderModel(
        id: '1044',
        customerName: 'Vikram Singh',
        customerPhone: '+91 98450 12345',
        items: ['1x Tandoori Chicken (Full)', '4x Roti'],
        totalAmount: '₹640',
        status: 'Preparing',
        time: '22 mins ago',
        address: 'H-Block, Sector 50, Noida',
      ),
      const OrderModel(
        id: '1043',
        customerName: 'Kavita Joshi',
        customerPhone: '+91 91234 56780',
        items: ['1x Paneer Tikka', '2x Rumali Roti'],
        totalAmount: '₹340',
        status: 'Completed',
        time: '45 mins ago',
        address: 'Sector 62, Noida',
      ),
      const OrderModel(
        id: '1042',
        customerName: 'Mohit Agarwal',
        customerPhone: '+91 90123 45678',
        items: ['1x Kadai Paneer', '3x Lachha Paratha'],
        totalAmount: '₹410',
        status: 'Completed',
        time: '1 hour ago',
        address: 'Sector 63, Noida',
      ),
      const OrderModel(
        id: '1041',
        customerName: 'Ananya Roy',
        customerPhone: '+91 98765 09876',
        items: ['1x Masala Dosa', '1x Filter Coffee'],
        totalAmount: '₹190',
        status: 'Delivered',
        time: '2 hours ago',
        address: 'Sector 18, Noida',
      ),
      const OrderModel(
        id: '1040',
        customerName: 'Deepak Kumar',
        customerPhone: '+91 94567 89012',
        items: ['2x Chole Bhature'],
        totalAmount: '₹240',
        status: 'Cancelled',
        time: '3 hours ago',
        address: 'Sector 12, Noida',
      ),
    ];
  }

  void acceptOrder(String orderId) {
    state = [
      for (final order in state)
        if (order.id == orderId)
          order.copyWith(status: 'Preparing', time: 'Just accepted')
        else
          order,
    ];
  }

  void rejectOrder(String orderId) {
    state = [
      for (final order in state)
        if (order.id == orderId)
          order.copyWith(status: 'Cancelled', time: 'Just rejected')
        else
          order,
    ];
  }

  void markOrderReady(String orderId) {
    state = [
      for (final order in state)
        if (order.id == orderId)
          order.copyWith(status: 'Ready', time: 'Ready for pickup')
        else
          order,
    ];
  }

  void completeOrder(String orderId) {
    state = [
      for (final order in state)
        if (order.id == orderId)
          order.copyWith(status: 'Completed', time: 'Just completed')
        else
          order,
    ];
  }
}

final ordersProvider = NotifierProvider<OrdersNotifier, List<OrderModel>>(
  OrdersNotifier.new,
);

final newOrdersProvider = Provider<List<OrderModel>>((ref) {
  final orders = ref.watch(ordersProvider);
  return orders
      .where((o) =>
          o.status.toLowerCase() == 'new' || o.status.toLowerCase() == 'pending')
      .toList();
});

final preparingOrdersProvider = Provider<List<OrderModel>>((ref) {
  final orders = ref.watch(ordersProvider);
  return orders
      .where((o) =>
          o.status.toLowerCase() == 'preparing' ||
          o.status.toLowerCase() == 'ready' ||
          o.status.toLowerCase() == 'active')
      .toList();
});

final pastOrdersProvider = Provider<List<OrderModel>>((ref) {
  final orders = ref.watch(ordersProvider);
  return orders
      .where((o) =>
          o.status.toLowerCase() == 'completed' ||
          o.status.toLowerCase() == 'delivered' ||
          o.status.toLowerCase() == 'cancelled')
      .toList();
});

final activeOrdersCountProvider = Provider<int>((ref) {
  final newCount = ref.watch(newOrdersProvider).length;
  final prepCount = ref.watch(preparingOrdersProvider).length;
  return newCount + prepCount;
});
