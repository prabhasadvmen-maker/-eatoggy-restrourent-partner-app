import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/subscriptions_plans_model.dart';

class SubscriptionsPlansState {
  const SubscriptionsPlansState({
    required this.model,
  });

  final SubscriptionsPlansModel model;

  SubscriptionsPlansState copyWith({
    SubscriptionsPlansModel? model,
  }) {
    return SubscriptionsPlansState(
      model: model ?? this.model,
    );
  }
}

class SubscriptionsPlansNotifier extends Notifier<SubscriptionsPlansState> {
  @override
  SubscriptionsPlansState build() {
    return const SubscriptionsPlansState(
      model: SubscriptionsPlansModel.dummy,
    );
  }
}

final subscriptionsPlansProvider =
    NotifierProvider<SubscriptionsPlansNotifier, SubscriptionsPlansState>(
  SubscriptionsPlansNotifier.new,
);
