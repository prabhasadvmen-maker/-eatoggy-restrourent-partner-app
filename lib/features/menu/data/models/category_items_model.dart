class CategoryFoodItem {
  const CategoryFoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.isVeg,
    required this.isAvailable,
    required this.imageAsset,
  });

  final String id;
  final String name;
  final String price;
  final bool isVeg;
  final bool isAvailable;
  final String imageAsset;

  CategoryFoodItem copyWith({
    String? id,
    String? name,
    String? price,
    bool? isVeg,
    bool? isAvailable,
    String? imageAsset,
  }) {
    return CategoryFoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      isVeg: isVeg ?? this.isVeg,
      isAvailable: isAvailable ?? this.isAvailable,
      imageAsset: imageAsset ?? this.imageAsset,
    );
  }
}

class CategoryItemsModel {
  const CategoryItemsModel({
    required this.categoryId,
    required this.categoryName,
    required this.itemsCountSubtitle,
    required this.allOnlineStatus,
    required this.items,
  });

  final String categoryId;
  final String categoryName;
  final String itemsCountSubtitle;
  final bool allOnlineStatus;
  final List<CategoryFoodItem> items;

  static const dummy = CategoryItemsModel(
    categoryId: '1',
    categoryName: 'North Indian',
    itemsCountSubtitle: '12 Items available',
    allOnlineStatus: true,
    items: [
      CategoryFoodItem(
        id: '1',
        name: 'Butter Chicken',
        price: '₹280',
        isVeg: false,
        isAvailable: true,
        imageAsset: 'assets/images/butter_chicken.png',
      ),
      CategoryFoodItem(
        id: '2',
        name: 'Dal Makhani',
        price: '₹180',
        isVeg: true,
        isAvailable: true,
        imageAsset: 'assets/images/dal_makhani.png',
      ),
      CategoryFoodItem(
        id: '3',
        name: 'Paneer Tikka',
        price: '₹220',
        isVeg: true,
        isAvailable: false,
        imageAsset: 'assets/images/paneer_tikka.png',
      ),
      CategoryFoodItem(
        id: '4',
        name: 'Chicken Biryani',
        price: '₹250',
        isVeg: false,
        isAvailable: true,
        imageAsset: 'assets/images/chicken_biryani.png',
      ),
    ],
  );
}
