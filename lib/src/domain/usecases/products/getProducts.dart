import 'package:goya/src/domain/models/products_model.dart';

abstract class GetProducts {
  Future<List<ProductsModel>> load();
}
