import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/main_shell_model.dart';

class MainShellState {
  const MainShellState({
    required this.data,
    this.currentIndex = 0,
  });

  final MainShellModel data;
  final int currentIndex;

  MainShellState copyWith({
    MainShellModel? data,
    int? currentIndex,
  }) {
    return MainShellState(
      data: data ?? this.data,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

class MainShellNotifier extends Notifier<MainShellState> {
  @override
  MainShellState build() {
    return const MainShellState(
      data: MainShellModel.dummy,
      currentIndex: 0,
    );
  }

  void changeTab(int index) {
    if (index >= 0 && index < state.data.tabs.length) {
      state = state.copyWith(currentIndex: index);
    }
  }
}

final mainShellProvider =
    NotifierProvider<MainShellNotifier, MainShellState>(
  MainShellNotifier.new,
);
