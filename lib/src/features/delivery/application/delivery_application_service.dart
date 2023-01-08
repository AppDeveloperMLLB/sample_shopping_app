import 'package:sample_shopping_app/src/features/order/application/order_status_data.dart';
import 'package:sample_shopping_app/src/features/order/domain/repository/order_repository.dart';
import 'package:sample_shopping_app/src/locator/repository_locator.dart';

class DelivelyApplicationService {
  Future<void> delivery(String orderId) async {
    final orderRepository = RepositoryLocator.instance.get<OrderRepository>();
    final order = await orderRepository.fetchUndeliveredOrder(orderId);
    if (order == null) {
      throw Exception("order is null");
    }
    orderRepository.addDeliverdOrder(order);
    orderRepository.deleteUndeliveredOrder(order);
    orderRepository.updateOrderStatus(
      OrderStatusData(
        orderId: order.id,
        status: OrderStatus.delivered,
      ),
    );
  }

  Future<void> undelivery(String orderId) async {
    final orderRepository = RepositoryLocator.instance.get<OrderRepository>();
    final order = await orderRepository.fetchDeliveredOrder(orderId);
    if (order == null) {
      throw Exception("order is null");
    }
    orderRepository.addUndeliveredOrder(order);
    orderRepository.deleteDeliveredOrder(order);
    orderRepository.updateOrderStatus(
      OrderStatusData(
        orderId: order.id,
        status: OrderStatus.undelivered,
      ),
    );
  }
}
