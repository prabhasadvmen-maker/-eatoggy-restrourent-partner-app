import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/category_items_model.dart';
import '../../data/models/menu_management_model.dart';
import 'menu_management_provider.dart';

class CategoryItemsState {
  const CategoryItemsState({
    required this.model,
    this.toggleAll = true,
  });

  final CategoryItemsModel model;
  final bool toggleAll;

  CategoryItemsState copyWith({
    CategoryItemsModel? model,
    bool? toggleAll,
  }) {
    return CategoryItemsState(
      model: model ?? this.model,
      toggleAll: toggleAll ?? this.toggleAll,
    );
  }
}

class CategoryItemsStatusNotifier
    extends Notifier<Map<String, Map<String, bool>>> {
  @override
  Map<String, Map<String, bool>> build() => {};

  void setItemStatus(String categoryId, String itemId, bool status) {
    final catMap = Map<String, bool>.from(state[categoryId] ?? {});
    catMap[itemId] = status;
    state = {...state, categoryId: catMap};
  }

  void setAllStatus(String categoryId, List<String> itemIds, bool status) {
    final catMap = <String, bool>{};
    for (final id in itemIds) {
      catMap[id] = status;
    }
    state = {...state, categoryId: catMap};
  }
}

final categoryItemsStatusProvider = NotifierProvider<
    CategoryItemsStatusNotifier, Map<String, Map<String, bool>>>(
  CategoryItemsStatusNotifier.new,
);

final categoryItemsProvider =
    Provider.family<CategoryItemsState, String>((ref, categoryId) {
  final categories = ref.watch(menuManagementProvider).model.categories;
  final category = categories.firstWhere(
    (c) => c.id == categoryId || c.title.toLowerCase() == categoryId.toLowerCase(),
    orElse: () => const MenuCategoryItem(
      id: '1',
      title: 'North Indian',
      itemCountText: '12 Items',
      iconEmoji: '🍲',
    ),
  );

  final statusMap = ref.watch(categoryItemsStatusProvider)[category.id] ?? {};

  final items = CategoryItemsModel.dummy.items.map((item) {
    final isAvailable = statusMap[item.id] ?? item.isAvailable;
    return item.copyWith(isAvailable: isAvailable);
  }).toList();

  final allOnline = items.every((i) => i.isAvailable);

  return CategoryItemsState(
    model: CategoryItemsModel(
      categoryId: category.id,
      categoryName: category.title,
      itemsCountSubtitle: '${category.itemCountText} available',
      allOnlineStatus: allOnline,
      items: items,
    ),
    toggleAll: allOnline,
  );
});
