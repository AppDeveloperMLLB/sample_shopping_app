import 'package:sample_shopping_app/src/features/product_list/domain/model/product.dart';

abstract class CartRepository {
  Future<void> add(Product product);
  Future<void> delete(Product product);
  Future<void> deleteAll();
  Future<List<Product>> getProducts();
}
