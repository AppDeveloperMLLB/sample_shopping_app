import 'package:sample_shopping_app/src/features/cart/application/product_in_cart.dart';
import 'package:sample_shopping_app/src/features/cart/domain/models/cart_item.dart';

abstract class OrderRepository {
  Future<void> add(Order order);
  Stream<List<Order>> watchOrder();
}

class Order {
  final String id;
  final String userId;
  final DateTime date;
  final String productId;
  final int num;

  Order({
    required this.id,
    required this.userId,
    required this.date,
    required this.productId,
    required this.num,
  });
}
