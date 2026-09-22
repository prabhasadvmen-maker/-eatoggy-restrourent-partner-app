class AddCategoryModel {
  const AddCategoryModel({
    required this.title,
    required this.subtitle,
    required this.categoryName,
    required this.description,
    required this.isActive,
    this.imagePath,
  });

  final String title;
  final String subtitle;
  final String categoryName;
  final String description;
  final bool isActive;
  final String? imagePath;

  static const dummyNew = AddCategoryModel(
    title: 'Add Category',
    subtitle: 'Create a new category for your menu',
    categoryName: '',
    description: '',
    isActive: true,
    imagePath: null,
  );

  static const dummyEdit = AddCategoryModel(
    title: 'Edit Category',
    subtitle: 'Update category details for your menu',
    categoryName: 'North Indian',
    description: 'Traditional clay oven baked breads, rich gravies and royal curries',
    isActive: true,
    imagePath: null,
  );

  AddCategoryModel copyWith({
    String? title,
    String? subtitle,
    String? categoryName,
    String? description,
    bool? isActive,
    String? imagePath,
    bool clearImage = false,
  }) {
    return AddCategoryModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      categoryName: categoryName ?? this.categoryName,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      imagePath: clearImage ? null : (imagePath ?? this.imagePath),
    );
  }
}
