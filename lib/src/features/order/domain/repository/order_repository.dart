import 'package:sample_shopping_app/src/features/order/application/order_status_data.dart';
import 'package:sample_shopping_app/src/features/order/domain/model/order.dart';

abstract class OrderRepository {
  Future<Order?> fetchUndeliveredOrder(String orderId);
  Future<void> addUndeliveredOrder(Order order);
  Future<void> deleteUndeliveredOrder(Order order);
  Future<void> addOrderStatus(OrderStatusData status);
  Future<void> updateOrderStatus(OrderStatusData status);
  Future<OrderStatusData?> fetchOrderStatus(String orderId);
  Future<void> addCanceledOrder(Order order);
  Future<void> addDeliverdOrder(Order order);
  Future<Order?> fetchDeliveredOrder(String orderId);
  Future<void> deleteDeliveredOrder(Order order);
  Stream<List<Order>> watchOrder();
}

enum OrderStatus {
  undelivered,
  delivered,
  canceled;

  @override
  String toString() {
    if (this == OrderStatus.undelivered) {
      return "配達中";
    }
    if (this == OrderStatus.delivered) {
      return "配達済み";
    }
    if (this == OrderStatus.canceled) {
      return "キャンセル済み";
    }

    return "";
  }
}
