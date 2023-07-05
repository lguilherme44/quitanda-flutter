import 'package:goya/src/models/categoties_model.dart';

abstract class GetCategory {
  Future<List<CategoriesModel>> load();
}
