import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/menu_management_model.dart';

class MenuManagementState {
  const MenuManagementState({
    required this.model,
    this.searchQuery = '',
  });

  final MenuManagementModel model;
  final String searchQuery;

  List<MenuCategoryItem> get filteredCategories {
    if (searchQuery.trim().isEmpty) {
      return model.categories;
    }
    final query = searchQuery.toLowerCase();
    return model.categories.where((cat) {
      return cat.title.toLowerCase().contains(query);
    }).toList();
  }

  MenuManagementState copyWith({
    MenuManagementModel? model,
    String? searchQuery,
  }) {
    return MenuManagementState(
      model: model ?? this.model,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class MenuManagementNotifier extends Notifier<MenuManagementState> {
  @override
  MenuManagementState build() {
    return const MenuManagementState(
      model: MenuManagementModel.dummy,
    );
  }

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void toggleCategory(String id, bool val) {
    final updatedCategories = state.model.categories.map((cat) {
      if (cat.id == id) {
        return cat.copyWith(isEnabled: val);
      }
      return cat;
    }).toList();

    state = state.copyWith(
      model: MenuManagementModel(
        title: state.model.title,
        subtitle: state.model.subtitle,
        searchHint: state.model.searchHint,
        categories: updatedCategories,
      ),
    );
  }
}

final menuManagementProvider =
    NotifierProvider<MenuManagementNotifier, MenuManagementState>(
  MenuManagementNotifier.new,
);
