import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/subscriber_card_model.dart';
import '../../data/models/tiffin_deliveries_model.dart';

class SubscriberCardState {
  const SubscriberCardState({
    required this.model,
    required this.isPaused,
  });

  final SubscriberCardModel model;
  final bool isPaused;

  SubscriberCardState copyWith({
    SubscriberCardModel? model,
    bool? isPaused,
  }) {
    return SubscriberCardState(
      model: model ?? this.model,
      isPaused: isPaused ?? this.isPaused,
    );
  }
}

class SubscriberCardNotifier extends Notifier<SubscriberCardState> {
  @override
  SubscriberCardState build() {
    return const SubscriberCardState(
      model: SubscriberCardModel.dummyPriya,
      isPaused: false,
    );
  }

  void initializeForCustomer(DeliveryMealItem item) {
    SubscriberCardModel base;
    if (item.customerName.toLowerCase().contains('rahul')) {
      base = SubscriberCardModel.dummyRahul;
    } else if (item.customerName.toLowerCase().contains('amit')) {
      base = SubscriberCardModel.dummyAmit;
    } else {
      base = SubscriberCardModel.dummyPriya;
    }

    final customized = base.copyWith(
      customerId: item.id,
      customerName: item.customerName,
      planTitle: '${item.mealType} Tiffin Plan',
    );

    state = SubscriberCardState(
      model: customized,
      isPaused: customized.isPaused,
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

  Future<void> callPartner() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: state.model.partnerPhoneNumber);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      }
    } catch (_) {}
  }
}

final subscriberCardProvider =
    NotifierProvider<SubscriberCardNotifier, SubscriberCardState>(
  SubscriberCardNotifier.new,
);
