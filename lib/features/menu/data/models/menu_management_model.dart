class MenuCategoryItem {
  const MenuCategoryItem({
    required this.id,
    required this.title,
    required this.itemCountText,
    required this.iconEmoji,
    this.isEnabled = true,
  });

  final String id;
  final String title;
  final String itemCountText;
  final String iconEmoji;
  final bool isEnabled;

  MenuCategoryItem copyWith({
    String? id,
    String? title,
    String? itemCountText,
    String? iconEmoji,
    bool? isEnabled,
  }) {
    return MenuCategoryItem(
      id: id ?? this.id,
      title: title ?? this.title,
      itemCountText: itemCountText ?? this.itemCountText,
      iconEmoji: iconEmoji ?? this.iconEmoji,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

class MenuManagementModel {
  const MenuManagementModel({
    required this.title,
    required this.subtitle,
    required this.searchHint,
    required this.categories,
  });

  final String title;
  final String subtitle;
  final String searchHint;
  final List<MenuCategoryItem> categories;

  static const dummy = MenuManagementModel(
    title: 'Menu Management',
    subtitle: 'Manage your food categories',
    searchHint: 'Search categories...',
    categories: [
      MenuCategoryItem(
        id: '1',
        title: 'North Indian',
        itemCountText: '12 Items',
        iconEmoji: '🍲',
        isEnabled: true,
      ),
      MenuCategoryItem(
        id: '2',
        title: 'South Indian',
        itemCountText: '8 Items',
        iconEmoji: '🍛',
        isEnabled: true,
      ),
      MenuCategoryItem(
        id: '3',
        title: 'Chinese',
        itemCountText: '6 Items',
        iconEmoji: '🍜',
        isEnabled: true,
      ),
      MenuCategoryItem(
        id: '4',
        title: 'Beverages',
        itemCountText: '10 Items',
        iconEmoji: '🥤',
        isEnabled: true,
      ),
      MenuCategoryItem(
        id: '5',
        title: 'Thali Combos',
        itemCountText: '4 Items',
        iconEmoji: '🍱',
        isEnabled: true,
      ),
      MenuCategoryItem(
        id: '6',
        title: 'Desserts',
        itemCountText: '5 Items',
        iconEmoji: '🧁',
        isEnabled: false,
      ),
    ],
  );
}
