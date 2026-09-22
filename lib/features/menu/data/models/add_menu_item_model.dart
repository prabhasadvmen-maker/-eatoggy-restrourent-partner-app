class PortionSizeVariant {
  const PortionSizeVariant({
    required this.id,
    required this.title,
    required this.price,
  });

  final String id;
  final String title;
  final String price;

  PortionSizeVariant copyWith({
    String? id,
    String? title,
    String? price,
  }) {
    return PortionSizeVariant(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
    );
  }
}

class DishAddon {
  const DishAddon({
    required this.id,
    required this.title,
    required this.price,
  });

  final String id;
  final String title;
  final String price;

  DishAddon copyWith({
    String? id,
    String? title,
    String? price,
  }) {
    return DishAddon(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
    );
  }
}

class AddMenuItemModel {
  const AddMenuItemModel({
    required this.title,
    required this.subtitle,
    required this.itemName,
    required this.description,
    required this.selectedCategory,
    required this.price,
    required this.prepTime,
    required this.isVeg,
    required this.isAvailableImmediately,
    required this.sizeVariantsSummary,
    required this.sizeVariantsPrice,
    required this.categories,
    required this.sizeVariants,
    required this.addons,
  });

  final String title;
  final String subtitle;
  final String itemName;
  final String description;
  final String selectedCategory;
  final String price;
  final String prepTime;
  final bool isVeg;
  final bool isAvailableImmediately;
  final String sizeVariantsSummary;
  final String sizeVariantsPrice;
  final List<String> categories;
  final List<PortionSizeVariant> sizeVariants;
  final List<DishAddon> addons;

  static const dummyNew = AddMenuItemModel(
    title: 'Add Menu Item',
    subtitle: 'Create brand new recipe listing',
    itemName: '',
    description: '',
    selectedCategory: 'North Indian',
    price: '',
    prepTime: '15',
    isVeg: true,
    isAvailableImmediately: true,
    sizeVariantsSummary: 'Half / Full Portion',
    sizeVariantsPrice: '₹120 / ₹220',
    categories: [
      'North Indian',
      'South Indian',
      'Chinese',
      'Beverages',
      'Thali Combos',
      'Desserts',
    ],
    sizeVariants: [
      PortionSizeVariant(id: '1', title: 'Half Portion', price: '₹120'),
      PortionSizeVariant(id: '2', title: 'Full Portion', price: '₹220'),
    ],
    addons: [
      DishAddon(id: '1', title: 'Extra Cheese', price: '+₹30'),
      DishAddon(id: '2', title: 'Extra Gravy', price: '+₹20'),
    ],
  );

  static const dummyEdit = AddMenuItemModel(
    title: 'Edit Menu Item',
    subtitle: 'Update your recipe listing details',
    itemName: 'Kadai Paneer',
    description:
        'Fresh cottage cheese cooked with onions, tomatoes and bell peppers in a traditional kadai...',
    selectedCategory: 'North Indian',
    price: '220',
    prepTime: '15',
    isVeg: true,
    isAvailableImmediately: true,
    sizeVariantsSummary: 'Half / Full Portion',
    sizeVariantsPrice: '₹120 / ₹220',
    categories: [
      'North Indian',
      'South Indian',
      'Chinese',
      'Beverages',
      'Thali Combos',
      'Desserts',
    ],
    sizeVariants: [
      PortionSizeVariant(id: '1', title: 'Half Portion', price: '₹120'),
      PortionSizeVariant(id: '2', title: 'Full Portion', price: '₹220'),
    ],
    addons: [
      DishAddon(id: '1', title: 'Extra Cheese', price: '+₹30'),
      DishAddon(id: '2', title: 'Extra Gravy', price: '+₹20'),
    ],
  );

  AddMenuItemModel copyWith({
    String? title,
    String? subtitle,
    String? itemName,
    String? description,
    String? selectedCategory,
    String? price,
    String? prepTime,
    bool? isVeg,
    bool? isAvailableImmediately,
    String? sizeVariantsSummary,
    String? sizeVariantsPrice,
    List<String>? categories,
    List<PortionSizeVariant>? sizeVariants,
    List<DishAddon>? addons,
  }) {
    return AddMenuItemModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      itemName: itemName ?? this.itemName,
      description: description ?? this.description,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      price: price ?? this.price,
      prepTime: prepTime ?? this.prepTime,
      isVeg: isVeg ?? this.isVeg,
      isAvailableImmediately:
          isAvailableImmediately ?? this.isAvailableImmediately,
      sizeVariantsSummary: sizeVariantsSummary ?? this.sizeVariantsSummary,
      sizeVariantsPrice: sizeVariantsPrice ?? this.sizeVariantsPrice,
      categories: categories ?? this.categories,
      sizeVariants: sizeVariants ?? this.sizeVariants,
      addons: addons ?? this.addons,
    );
  }
}
