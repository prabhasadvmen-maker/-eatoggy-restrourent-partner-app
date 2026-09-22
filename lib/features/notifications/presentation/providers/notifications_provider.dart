import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/notifications_model.dart';

class NotificationsState {
  const NotificationsState({
    required this.model,
  });

  final NotificationsPageModel model;

  NotificationsState copyWith({
    NotificationsPageModel? model,
  }) {
    return NotificationsState(
      model: model ?? this.model,
    );
  }
}

class NotificationsNotifier extends Notifier<NotificationsState> {
  @override
  NotificationsState build() {
    return const NotificationsState(
      model: NotificationsPageModel.dummy,
    );
  }

  void markAllRead() {
    final updatedSections = state.model.sections.map((section) {
      final updatedItems = section.items.map((item) {
        return item.copyWith(isUnread: false);
      }).toList();
      return NotificationsSection(
        sectionTitle: section.sectionTitle,
        items: updatedItems,
      );
    }).toList();

    state = state.copyWith(
      model: NotificationsPageModel(
        title: state.model.title,
        actionText: state.model.actionText,
        sections: updatedSections,
      ),
    );
  }

  void markItemRead(String itemId) {
    final updatedSections = state.model.sections.map((section) {
      final updatedItems = section.items.map((item) {
        if (item.id == itemId) {
          return item.copyWith(isUnread: false);
        }
        return item;
      }).toList();
      return NotificationsSection(
        sectionTitle: section.sectionTitle,
        items: updatedItems,
      );
    }).toList();

    state = state.copyWith(
      model: NotificationsPageModel(
        title: state.model.title,
        actionText: state.model.actionText,
        sections: updatedSections,
      ),
    );
  }
}

final notificationsProvider =
    NotifierProvider<NotificationsNotifier, NotificationsState>(
  NotificationsNotifier.new,
);
