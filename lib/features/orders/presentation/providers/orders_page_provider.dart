import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/orders_page_model.dart';

class OrdersPageState {
  const OrdersPageState({
    required this.data,
    this.activeFilter = 'new',
    this.ordersList = const [],
  });

  final OrdersPageModel data;
  final String activeFilter;
  final List<OrderItemDetail> ordersList;

  List<OrdersFilterTab> get filterTabsWithCounts {
    final newCount = ordersList.where((o) => o.status == 'New').length;
    final preparingCount = ordersList.where((o) => o.status == 'Preparing').length;
    final readyCount = ordersList.where((o) => o.status == 'Ready').length;
    final completedCount = ordersList.where((o) => o.status == 'Completed').length;
    final allCount = ordersList.length;

    return [
      OrdersFilterTab(id: 'all', label: 'All', badgeCount: allCount),
      OrdersFilterTab(id: 'new', label: 'New', badgeCount: newCount),
      OrdersFilterTab(id: 'preparing', label: 'Preparing', badgeCount: preparingCount),
      OrdersFilterTab(id: 'ready', label: 'Ready', badgeCount: readyCount),
      OrdersFilterTab(id: 'completed', label: 'Completed', badgeCount: completedCount),
    ];
  }

  List<OrderItemDetail> get filteredOrders {
    if (activeFilter == 'all') return ordersList;
    if (activeFilter == 'new') {
      return ordersList.where((o) => o.status == 'New').toList();
    }
    if (activeFilter == 'preparing') {
      return ordersList.where((o) => o.status == 'Preparing').toList();
    }
    if (activeFilter == 'ready') {
      return ordersList.where((o) => o.status == 'Ready').toList();
    }
    if (activeFilter == 'completed') {
      return ordersList.where((o) => o.status == 'Completed').toList();
    }
    return ordersList;
  }

  OrdersPageState copyWith({
    OrdersPageModel? data,
    String? activeFilter,
    List<OrderItemDetail>? ordersList,
  }) {
    return OrdersPageState(
      data: data ?? this.data,
      activeFilter: activeFilter ?? this.activeFilter,
      ordersList: ordersList ?? this.ordersList,
    );
  }
}

class OrdersPageNotifier extends Notifier<OrdersPageState> {
  @override
  OrdersPageState build() {
    const dummyModel = OrdersPageModel.dummy;
    return OrdersPageState(
      data: dummyModel,
      activeFilter: 'new',
      ordersList: dummyModel.orders,
    );
  }

  void selectFilter(String filterId) {
    state = state.copyWith(activeFilter: filterId);
  }

  void updateOrderStatus(String orderId, String newStatus) {
    final updatedList = state.ordersList.map((order) {
      if (order.id == orderId) {
        return OrderItemDetail(
          id: order.id,
          orderNumber: order.orderNumber,
          timeAgo: order.timeAgo,
          amount: order.amount,
          customerName: order.customerName,
          itemsList: order.itemsList,
          status: newStatus,
        );
      }
      return order;
    }).toList();

    state = state.copyWith(ordersList: updatedList);
  }

  void acceptOrder(String orderId) {
    updateOrderStatus(orderId, 'Preparing');
  }

  void markReady(String orderId) {
    updateOrderStatus(orderId, 'Ready');
  }

  void markCompleted(String orderId) {
    updateOrderStatus(orderId, 'Completed');
  }

  void rejectOrder(String orderId) {
    final updatedList = state.ordersList.where((o) => o.id != orderId).toList();
    state = state.copyWith(ordersList: updatedList);
  }
}

final ordersPageProvider =
    NotifierProvider<OrdersPageNotifier, OrdersPageState>(
  OrdersPageNotifier.new,
);
