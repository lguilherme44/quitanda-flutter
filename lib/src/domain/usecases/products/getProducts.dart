import 'package:goya/src/models/item_model.dart';

abstract class GetProducts {
  Future<List<ItemModel>> load();
}
