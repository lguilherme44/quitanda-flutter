import 'package:goya/src/models/products_model.dart';

abstract class GetProducts {
  Future<List<ProductsModel>> load();
}
