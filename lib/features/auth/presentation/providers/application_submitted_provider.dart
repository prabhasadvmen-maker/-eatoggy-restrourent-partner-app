import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/application_submitted_model.dart';

class ApplicationSubmittedState {
  const ApplicationSubmittedState({
    required this.data,
  });

  final ApplicationSubmittedModel data;
}

class ApplicationSubmittedNotifier
    extends Notifier<ApplicationSubmittedState> {
  @override
  ApplicationSubmittedState build() {
    return const ApplicationSubmittedState(
      data: ApplicationSubmittedModel.dummy,
    );
  }
}

final applicationSubmittedProvider = NotifierProvider<
    ApplicationSubmittedNotifier, ApplicationSubmittedState>(
  ApplicationSubmittedNotifier.new,
);
