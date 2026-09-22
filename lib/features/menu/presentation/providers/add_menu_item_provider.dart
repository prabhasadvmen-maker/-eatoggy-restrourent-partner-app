import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/add_menu_item_model.dart';
import '../../data/models/category_items_model.dart';

class AddMenuItemState {
  const AddMenuItemState({
    required this.model,
    required this.isVeg,
    required this.isAvailable,
    required this.selectedCategory,
    required this.hasImage,
    required this.sizeVariants,
    required this.addons,
    this.imagePath,
    this.isSaving = false,
  });

  final AddMenuItemModel model;
  final bool isVeg;
  final bool isAvailable;
  final String selectedCategory;
  final bool hasImage;
  final String? imagePath;
  final List<PortionSizeVariant> sizeVariants;
  final List<DishAddon> addons;
  final bool isSaving;

  AddMenuItemState copyWith({
    AddMenuItemModel? model,
    bool? isVeg,
    bool? isAvailable,
    String? selectedCategory,
    bool? hasImage,
    String? imagePath,
    bool clearImage = false,
    List<PortionSizeVariant>? sizeVariants,
    List<DishAddon>? addons,
    bool? isSaving,
  }) {
    return AddMenuItemState(
      model: model ?? this.model,
      isVeg: isVeg ?? this.isVeg,
      isAvailable: isAvailable ?? this.isAvailable,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      hasImage: clearImage ? false : (hasImage ?? this.hasImage),
      imagePath: clearImage ? null : (imagePath ?? this.imagePath),
      sizeVariants: sizeVariants ?? this.sizeVariants,
      addons: addons ?? this.addons,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class AddMenuItemNotifier extends Notifier<AddMenuItemState> {
  final ImagePicker _picker = ImagePicker();

  @override
  AddMenuItemState build() {
    final initialModel = AddMenuItemModel.dummyNew;
    return AddMenuItemState(
      model: initialModel,
      isVeg: initialModel.isVeg,
      isAvailable: initialModel.isAvailableImmediately,
      selectedCategory: initialModel.selectedCategory,
      hasImage: false,
      imagePath: null,
      sizeVariants: initialModel.sizeVariants,
      addons: initialModel.addons,
    );
  }

  void initialize({bool isEdit = false, CategoryFoodItem? item}) {
    final baseModel = isEdit ? AddMenuItemModel.dummyEdit : AddMenuItemModel.dummyNew;
    final initialVeg = item != null ? item.isVeg : baseModel.isVeg;
    final initialAvailable = item != null ? item.isAvailable : baseModel.isAvailableImmediately;

    state = AddMenuItemState(
      model: baseModel,
      isVeg: initialVeg,
      isAvailable: initialAvailable,
      selectedCategory: baseModel.selectedCategory,
      hasImage: isEdit,
      imagePath: null,
      sizeVariants: baseModel.sizeVariants,
      addons: baseModel.addons,
    );
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (file != null) {
        state = state.copyWith(
          hasImage: true,
          imagePath: file.path,
        );
      }
    } catch (_) {}
  }

  void removeImage() {
    state = state.copyWith(clearImage: true);
  }

  void toggleVeg(bool isVeg) {
    state = state.copyWith(isVeg: isVeg);
  }

  void toggleAvailable(bool isAvailable) {
    state = state.copyWith(isAvailable: isAvailable);
  }

  void selectCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  void addSizeVariant(String title, String price) {
    final newVariant = PortionSizeVariant(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      price: price.startsWith('₹') ? price : '₹$price',
    );
    state = state.copyWith(sizeVariants: [...state.sizeVariants, newVariant]);
  }

  void addAddon(String title, String price) {
    final formattedPrice = price.startsWith('+')
        ? price
        : (price.startsWith('₹') ? '+$price' : '+₹$price');
    final newAddon = DishAddon(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      price: formattedPrice,
    );
    state = state.copyWith(addons: [...state.addons, newAddon]);
  }
}

final addMenuItemProvider =
    NotifierProvider<AddMenuItemNotifier, AddMenuItemState>(
  AddMenuItemNotifier.new,
);
