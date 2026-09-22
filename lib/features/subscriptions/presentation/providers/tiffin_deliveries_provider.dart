import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/tiffin_deliveries_model.dart';

class TiffinDeliveriesState {
  const TiffinDeliveriesState({
    required this.model,
    required this.selectedMealType, // 'Lunch' or 'Dinner'
    this.selectedDate = 'Today, 15 Aug 2026',
  });

  final TiffinDeliveriesModel model;
  final String selectedMealType;
  final String selectedDate;

  List<DeliveryMealItem> get filteredDeliveries {
    return model.deliveries
        .where((d) => d.mealType.toLowerCase() == selectedMealType.toLowerCase())
        .toList();
  }

  TiffinDeliveriesState copyWith({
    TiffinDeliveriesModel? model,
    String? selectedMealType,
    String? selectedDate,
  }) {
    return TiffinDeliveriesState(
      model: model ?? this.model,
      selectedMealType: selectedMealType ?? this.selectedMealType,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

class TiffinDeliveriesNotifier extends Notifier<TiffinDeliveriesState> {
  @override
  TiffinDeliveriesState build() {
    return const TiffinDeliveriesState(
      model: TiffinDeliveriesModel.dummy,
      selectedMealType: 'Lunch',
    );
  }

  void selectMealType(String type) {
    state = state.copyWith(selectedMealType: type);
  }

  void updateDate(String date) {
    state = state.copyWith(selectedDate: date);
  }

  void markAllPacked() {
    final updatedList = state.model.deliveries.map((item) {
      if (item.mealType.toLowerCase() == state.selectedMealType.toLowerCase()) {
        return DeliveryMealItem(
          id: item.id,
          customerName: item.customerName,
          status: 'PACKED',
          itemsText: item.itemsText,
          slotText: item.slotText,
          mealType: item.mealType,
        );
      }
      return item;
    }).toList();

    state = state.copyWith(
      model: state.model.copyWith(
        deliveries: updatedList,
        packedCount: state.model.totalCount,
      ),
    );
  }
}

final tiffinDeliveriesProvider =
    NotifierProvider<TiffinDeliveriesNotifier, TiffinDeliveriesState>(
  TiffinDeliveriesNotifier.new,
);
