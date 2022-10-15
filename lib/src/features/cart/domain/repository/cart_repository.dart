import 'package:sample_shopping_app/src/features/cart/application/product_in_cart.dart';
import 'package:sample_shopping_app/src/features/cart/domain/models/cart_item.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/model/product.dart';

abstract class CartRepository {
  Stream<List<ProductInCart>> watchCart();
  Future<void> add(CartItem item);
  Future<void> update(CartItem item);
  Future<CartItem> getCartItem(String productId);
  Future<void> delete(String productId);
  Future<void> deleteAll();
  Future<List<CartItem>> getAllItemsInCart();
}
