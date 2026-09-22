import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuItemModel {
  const MenuItemModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.isAvailable,
    required this.isVeg,
    this.prepTime = '15',
  });

  final String id;
  final String name;
  final String category;
  final String price;
  final String description;
  final bool isAvailable;
  final bool isVeg;
  final String prepTime;

  MenuItemModel copyWith({
    String? id,
    String? name,
    String? category,
    String? price,
    String? description,
    bool? isAvailable,
    bool? isVeg,
    String? prepTime,
  }) {
    return MenuItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      description: description ?? this.description,
      isAvailable: isAvailable ?? this.isAvailable,
      isVeg: isVeg ?? this.isVeg,
      prepTime: prepTime ?? this.prepTime,
    );
  }
}

class MenuNotifier extends Notifier<List<MenuItemModel>> {
  @override
  List<MenuItemModel> build() {
    return const [
      MenuItemModel(
        id: 'm1',
        name: 'Paneer Butter Masala',
        category: 'Main Course',
        price: '₹280',
        description: 'Fresh cottage cheese cubes in rich and velvety tomato cashew gravy.',
        isAvailable: true,
        isVeg: true,
      ),
      MenuItemModel(
        id: 'm2',
        name: 'Butter Chicken',
        category: 'Main Course',
        price: '₹350',
        description: 'Tender roasted chicken cooked in a rich, buttery, spiced tomato cream sauce.',
        isAvailable: true,
        isVeg: false,
      ),
      MenuItemModel(
        id: 'm3',
        name: 'Dal Makhani',
        category: 'Main Course',
        price: '₹240',
        description: 'Slow-cooked black lentils with white butter, cream, and aromatic Indian spices.',
        isAvailable: true,
        isVeg: true,
      ),
      MenuItemModel(
        id: 'm4',
        name: 'Crispy Corn Salt & Pepper',
        category: 'Starters',
        price: '₹190',
        description: 'Crispy sweet corn kernels tossed with chopped bell peppers, garlic, and scallions.',
        isAvailable: true,
        isVeg: true,
      ),
      MenuItemModel(
        id: 'm5',
        name: 'Chicken Tikka Boneless',
        category: 'Starters',
        price: '₹320',
        description: 'Marinated chicken chunks cooked in clay tandoor oven, served with mint chutney.',
        isAvailable: false,
        isVeg: false,
      ),
      MenuItemModel(
        id: 'm6',
        name: 'Garlic Butter Naan',
        category: 'Breads & Rice',
        price: '₹55',
        description: 'Clay oven baked flatbread infused with fresh minced garlic and melted butter.',
        isAvailable: true,
        isVeg: true,
      ),
      MenuItemModel(
        id: 'm7',
        name: 'Hyderabadi Veg Biryani',
        category: 'Breads & Rice',
        price: '₹270',
        description: 'Fragrant basmati rice dum cooked with marinated fresh vegetables and saffron.',
        isAvailable: true,
        isVeg: true,
      ),
      MenuItemModel(
        id: 'm8',
        name: 'Mango Lassi',
        category: 'Beverages',
        price: '₹110',
        description: 'Thick and creamy yogurt smoothie churned with sweet Alphonso mango pulp.',
        isAvailable: true,
        isVeg: true,
      ),
      MenuItemModel(
        id: 'm9',
        name: 'Hot Gulab Jamun (2 Pcs)',
        category: 'Desserts',
        price: '₹90',
        description: 'Soft fried milk-solid dough balls soaked in fragrant rose-cardamom sugar syrup.',
        isAvailable: true,
        isVeg: true,
      ),
    ];
  }

  void toggleAvailability(String id) {
    state = [
      for (final item in state)
        if (item.id == id)
          item.copyWith(isAvailable: !item.isAvailable)
        else
          item,
    ];
  }

  void addMenuItem(MenuItemModel item) {
    state = [item, ...state];
  }

  void updateMenuItem(MenuItemModel updatedItem) {
    state = [
      for (final item in state)
        if (item.id == updatedItem.id) updatedItem else item,
    ];
  }
}

final menuProvider = NotifierProvider<MenuNotifier, List<MenuItemModel>>(
  MenuNotifier.new,
);

class MenuCategoryFilterNotifier extends Notifier<String> {
  @override
  String build() => 'All';

  void setCategory(String category) => state = category;
}

final menuCategoryFilterProvider =
    NotifierProvider<MenuCategoryFilterNotifier, String>(
  MenuCategoryFilterNotifier.new,
);

class MenuVegFilterNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;
  void reset() => state = false;
}

final menuVegFilterProvider =
    NotifierProvider<MenuVegFilterNotifier, bool>(
  MenuVegFilterNotifier.new,
);

class MenuSearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) => state = query;
  void clear() => state = '';
}

final menuSearchQueryProvider =
    NotifierProvider<MenuSearchQueryNotifier, String>(
  MenuSearchQueryNotifier.new,
);

final filteredMenuItemsProvider = Provider<List<MenuItemModel>>((ref) {
  final items = ref.watch(menuProvider);
  final category = ref.watch(menuCategoryFilterProvider);
  final onlyVeg = ref.watch(menuVegFilterProvider);
  final search = ref.watch(menuSearchQueryProvider).toLowerCase().trim();

  return items.where((item) {
    if (category != 'All' && item.category != category) {
      return false;
    }
    if (onlyVeg && !item.isVeg) {
      return false;
    }
    if (search.isNotEmpty) {
      final name = item.name.toLowerCase();
      final desc = item.description.toLowerCase();
      return name.contains(search) || desc.contains(search);
    }
    return true;
  }).toList();
});
