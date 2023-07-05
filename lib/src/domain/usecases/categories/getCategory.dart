import 'package:goya/src/domain/models/categoties_model.dart';

abstract class GetCategory {
  Future<List<CategoriesModel>> load();
}
