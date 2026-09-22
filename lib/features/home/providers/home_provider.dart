import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/home_model.dart';

class HomeState {
  const HomeState({
    required this.data,
    this.isOnline = true,
  });

  final HomeModel data;
  final bool isOnline;

  HomeState copyWith({
    HomeModel? data,
    bool? isOnline,
  }) {
    return HomeState(
      data: data ?? this.data,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}

class HomeNotifier extends Notifier<HomeState> {
  @override
  HomeState build() {
    return const HomeState(
      data: HomeModel.dummy,
      isOnline: true,
    );
  }

  void toggleOnline(bool value) {
    state = state.copyWith(isOnline: value);
  }
}

final homeProvider = NotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);
