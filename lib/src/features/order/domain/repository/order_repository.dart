import 'package:sample_shopping_app/src/features/order/application/order_status_data.dart';
import 'package:sample_shopping_app/src/features/order/domain/model/order.dart';

abstract class OrderRepository {
  Future<void> addOrder(Order order);
  Future<void> deleteOrder(Order order);
  Future<void> addOrderStatus(OrderStatusData status);
  Future<void> updateOrderStatus(OrderStatusData status);
  Future<OrderStatusData?> fetchOrderStatus(String orderId);
  Future<void> addCanceledOrder(Order order);
  Future<void> addDeliverdOrder(Order order);
  Stream<List<Order>> watchOrder();
}

enum OrderStatus {
  undelivered,
  delivered,
  canceled,
}
