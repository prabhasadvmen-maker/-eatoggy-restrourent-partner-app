import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/add_category_model.dart';
import '../../data/models/menu_management_model.dart';

class AddCategoryState {
  const AddCategoryState({
    required this.model,
    required this.isActive,
    this.imagePath,
    this.isSaving = false,
  });

  final AddCategoryModel model;
  final bool isActive;
  final String? imagePath;
  final bool isSaving;

  AddCategoryState copyWith({
    AddCategoryModel? model,
    bool? isActive,
    String? imagePath,
    bool clearImage = false,
    bool? isSaving,
  }) {
    return AddCategoryState(
      model: model ?? this.model,
      isActive: isActive ?? this.isActive,
      imagePath: clearImage ? null : (imagePath ?? this.imagePath),
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class AddCategoryNotifier extends Notifier<AddCategoryState> {
  final ImagePicker _picker = ImagePicker();

  @override
  AddCategoryState build() {
    return const AddCategoryState(
      model: AddCategoryModel.dummyNew,
      isActive: true,
      imagePath: null,
    );
  }

  void initialize({bool isEdit = false, MenuCategoryItem? category, String? categoryName}) {
    final base = isEdit ? AddCategoryModel.dummyEdit : AddCategoryModel.dummyNew;
    final initialName = category?.title ?? categoryName ?? base.categoryName;
    final initialActive = category?.isEnabled ?? base.isActive;

    state = AddCategoryState(
      model: base.copyWith(
        categoryName: initialName,
        isActive: initialActive,
      ),
      isActive: initialActive,
      imagePath: null,
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
          imagePath: file.path,
        );
      }
    } catch (_) {}
  }

  void removeImage() {
    state = state.copyWith(clearImage: true);
  }

  void toggleActive(bool val) {
    state = state.copyWith(isActive: val);
  }
}

final addCategoryProvider =
    NotifierProvider<AddCategoryNotifier, AddCategoryState>(
  AddCategoryNotifier.new,
);
