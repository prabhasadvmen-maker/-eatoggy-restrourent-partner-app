import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/create_tiffin_plan_model.dart';

class CreateTiffinPlanState {
  const CreateTiffinPlanState({
    required this.model,
    required this.selectedCycleType,
    required this.mealsPerDay,
    required this.rotatingWeeklyMenu,
    this.isPublishing = false,
  });

  final CreateTiffinPlanModel model;
  final String selectedCycleType;
  final int mealsPerDay;
  final bool rotatingWeeklyMenu;
  final bool isPublishing;

  CreateTiffinPlanState copyWith({
    CreateTiffinPlanModel? model,
    String? selectedCycleType,
    int? mealsPerDay,
    bool? rotatingWeeklyMenu,
    bool? isPublishing,
  }) {
    return CreateTiffinPlanState(
      model: model ?? this.model,
      selectedCycleType: selectedCycleType ?? this.selectedCycleType,
      mealsPerDay: mealsPerDay ?? this.mealsPerDay,
      rotatingWeeklyMenu: rotatingWeeklyMenu ?? this.rotatingWeeklyMenu,
      isPublishing: isPublishing ?? this.isPublishing,
    );
  }
}

class CreateTiffinPlanNotifier extends Notifier<CreateTiffinPlanState> {
  @override
  CreateTiffinPlanState build() {
    final defaultModel = CreateTiffinPlanModel.dummy;
    return CreateTiffinPlanState(
      model: defaultModel,
      selectedCycleType: defaultModel.selectedCycleType,
      mealsPerDay: defaultModel.mealsPerDay,
      rotatingWeeklyMenu: defaultModel.rotatingWeeklyMenu,
    );
  }

  void selectCycleType(String cycle) {
    state = state.copyWith(selectedCycleType: cycle);
  }

  void selectMealsPerDay(int count) {
    state = state.copyWith(mealsPerDay: count);
  }

  void toggleRotatingWeeklyMenu(bool val) {
    state = state.copyWith(rotatingWeeklyMenu: val);
  }
}

final createTiffinPlanProvider =
    NotifierProvider<CreateTiffinPlanNotifier, CreateTiffinPlanState>(
  CreateTiffinPlanNotifier.new,
);
