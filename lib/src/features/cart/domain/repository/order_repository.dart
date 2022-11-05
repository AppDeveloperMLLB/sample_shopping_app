import 'package:sample_shopping_app/src/features/cart/application/product_in_cart.dart';
import 'package:sample_shopping_app/src/features/cart/domain/models/cart_item.dart';

abstract class OrderRepository {
  Future<void> add(Order order);
}

class Order {
  final String id;
  final DateTime date;
  final List<CartItem> cartItems;

  Order({required this.id, required this.date, required this.cartItems});
}
