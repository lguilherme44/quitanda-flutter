import 'package:flutter/foundation.dart';
import 'package:goya/src/domain/models/categoties_model.dart';
import 'package:goya/src/main/factories/services/category/category_service.dart';

enum CategoryState { idle, success, error, loading }

class CategoryController extends ChangeNotifier {
  final service = makeCategoryService();

  var state = CategoryState.idle;

  late List<CategoriesModel> categories;

  Future<void> fetchCategories() async {
    try {
      state = CategoryState.loading;
      categories = await service.load();
      state = CategoryState.success;
      notifyListeners();
    } catch (e) {
      state = CategoryState.error;
      notifyListeners();
    } finally {
      state = CategoryState.idle;
      notifyListeners();
    }
  }
}
