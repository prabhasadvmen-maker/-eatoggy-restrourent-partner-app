import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/kitchen_model.dart';

class KitchenState {
  const KitchenState({
    required this.model,
    this.isOnline = true,
    this.autoAcceptSubscription = true,
  });

  final KitchenScreenModel model;
  final bool isOnline;
  final bool autoAcceptSubscription;

  KitchenState copyWith({
    KitchenScreenModel? model,
    bool? isOnline,
    bool? autoAcceptSubscription,
  }) {
    return KitchenState(
      model: model ?? this.model,
      isOnline: isOnline ?? this.isOnline,
      autoAcceptSubscription:
          autoAcceptSubscription ?? this.autoAcceptSubscription,
    );
  }
}

class KitchenNotifier extends Notifier<KitchenState> {
  @override
  KitchenState build() {
    return const KitchenState(
      model: KitchenScreenModel.dummy,
      isOnline: true,
      autoAcceptSubscription: true,
    );
  }

  void toggleOnline(bool val) {
    state = state.copyWith(isOnline: val);
  }

  void toggleAutoAccept(bool val) {
    state = state.copyWith(autoAcceptSubscription: val);
  }

  void setOffline() {
    state = state.copyWith(isOnline: false);
  }
}

final kitchenProvider = NotifierProvider<KitchenNotifier, KitchenState>(
  KitchenNotifier.new,
);
