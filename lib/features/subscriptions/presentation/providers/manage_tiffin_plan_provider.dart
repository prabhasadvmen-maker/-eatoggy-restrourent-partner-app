import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/manage_tiffin_plan_model.dart';

class ManageTiffinPlanState {
  const ManageTiffinPlanState({
    required this.model,
    required this.isPaused,
    this.searchQuery = '',
    this.isSearchActive = false,
  });

  final ManageTiffinPlanModel model;
  final bool isPaused;
  final String searchQuery;
  final bool isSearchActive;

  List<SubscriberItem> get filteredSubscribers {
    if (searchQuery.trim().isEmpty) {
      return model.subscribers;
    }
    final query = searchQuery.toLowerCase();
    return model.subscribers.where((sub) {
      return sub.name.toLowerCase().contains(query) ||
          sub.phone.contains(query);
    }).toList();
  }

  ManageTiffinPlanState copyWith({
    ManageTiffinPlanModel? model,
    bool? isPaused,
    String? searchQuery,
    bool? isSearchActive,
  }) {
    return ManageTiffinPlanState(
      model: model ?? this.model,
      isPaused: isPaused ?? this.isPaused,
      searchQuery: searchQuery ?? this.searchQuery,
      isSearchActive: isSearchActive ?? this.isSearchActive,
    );
  }
}

class ManageTiffinPlanNotifier extends Notifier<ManageTiffinPlanState> {
  @override
  ManageTiffinPlanState build() {
    return const ManageTiffinPlanState(
      model: ManageTiffinPlanModel.dummyMonthlyLunch,
      isPaused: false,
    );
  }

  void initializeForProgram(String programId) {
    final selectedModel = (programId == '2' || programId.toLowerCase().contains('dinner'))
        ? ManageTiffinPlanModel.dummyWeeklyDinner
        : ManageTiffinPlanModel.dummyMonthlyLunch;

    state = ManageTiffinPlanState(
      model: selectedModel,
      isPaused: selectedModel.isPaused,
    );
  }

  void togglePausePlan() {
    final nextPaused = !state.isPaused;
    state = state.copyWith(
      isPaused: nextPaused,
      model: state.model.copyWith(
        isPaused: nextPaused,
        statusText: nextPaused ? 'PAUSED' : 'ACTIVE',
      ),
    );
  }

  void toggleSearch() {
    state = state.copyWith(
      isSearchActive: !state.isSearchActive,
      searchQuery: '',
    );
  }

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }
}

final manageTiffinPlanProvider =
    NotifierProvider<ManageTiffinPlanNotifier, ManageTiffinPlanState>(
  ManageTiffinPlanNotifier.new,
);
