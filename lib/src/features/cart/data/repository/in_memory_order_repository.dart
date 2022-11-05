import 'package:sample_shopping_app/src/features/cart/application/product_in_cart.dart';
import 'package:sample_shopping_app/src/features/cart/domain/models/cart_item.dart';
import 'package:sample_shopping_app/src/features/cart/domain/repository/cart_repository.dart';
import 'package:sample_shopping_app/src/features/cart/domain/repository/order_repository.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/model/product.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/repository/product_repository.dart';
import 'package:sample_shopping_app/src/locator/repository_locator.dart';
import 'package:sample_shopping_app/src/utils/in_memory_store.dart';

class InMemoryOrderRepository implements OrderRepository {
  InMemoryOrderRepository._();
  static final instance = InMemoryOrderRepository._();
  final _order = InMemoryStore<List<Order>>([]);
  final List<Order> _orderList = [];

  @override
  Future<void> add(Order order) async {
    _orderList.add(order);
    _order.value = _orderList;
  }
}
