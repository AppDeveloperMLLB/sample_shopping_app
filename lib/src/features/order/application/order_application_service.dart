import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/order/application/order_status_data.dart';
import 'package:sample_shopping_app/src/features/order/domain/model/order.dart';
import 'package:sample_shopping_app/src/features/order/domain/repository/order_repository.dart';
import 'package:sample_shopping_app/src/locator/repository_locator.dart';

class OrderApplicationService {
  final orderRepository = RepositoryLocator.instance.get<OrderRepository>();

  Future<void> cancelOrder(Order order) async {
    await orderRepository.addCanceledOrder(order);
    await orderRepository.deleteUndeliveredOrder(order);
    await _updateOrderStatus(order.id, OrderStatus.canceled);
  }

  Future<void> _updateOrderStatus(
      String orderId, OrderStatus orderStatus) async {
    final orderStatusData = await orderRepository.fetchOrderStatus(orderId);
    if (orderStatusData == null) {
      await orderRepository.addOrderStatus(
          OrderStatusData(orderId: orderId, status: orderStatus));
      return;
    }

    final updateOrderStatusData = orderStatusData.copyWith(status: orderStatus);
    await orderRepository.updateOrderStatus(updateOrderStatusData);
  }
}

/// 未配達、キャンセル、配達済みの全注文のStream
final allOrderStreamProvider = StreamProvider<List<Order>>((ref) {
  final orderRepository = RepositoryLocator.instance.get<OrderRepository>();
  return orderRepository.watchOrder();
});
