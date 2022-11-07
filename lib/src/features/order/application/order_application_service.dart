import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/cart/domain/repository/order_repository.dart';
import 'package:sample_shopping_app/src/features/order/application/order_data.dart';
import 'package:sample_shopping_app/src/locator/repository_locator.dart';

class OrderApplicationService {

}

final orderListProvider = StreamProvider<List<Order>>((ref) {
  final orderRepository = RepositoryLocator.instance.get<OrderRepository>();
  return orderRepository.watchOrder();
});
