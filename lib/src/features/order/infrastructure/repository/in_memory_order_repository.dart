import 'package:sample_shopping_app/src/features/order/application/order_status_data.dart';
import 'package:sample_shopping_app/src/features/order/domain/model/order.dart';
import 'package:sample_shopping_app/src/features/order/domain/repository/order_repository.dart';
import 'package:sample_shopping_app/src/utils/in_memory_store.dart';

class InMemoryOrderRepository implements OrderRepository {
  InMemoryOrderRepository._();
  static final instance = InMemoryOrderRepository._();
  final _order = InMemoryStore<List<Order>>([]);
  final List<Order> _undeliveedOrderList = [];
  final List<Order> _canceledOrderList = [];
  final List<Order> _deliveredOrderList = [];
  final List<OrderStatusData> _orderStatusDataList = [];

  @override
  Future<void> addOrder(Order order) async {
    _undeliveedOrderList.add(order);
    _order.value = _undeliveedOrderList.toList();
  }

  @override
  Stream<List<Order>> watchOrder() {
    return _order.stream;
  }

  @override
  Future<void> addCanceledOrder(Order order) async {
    _canceledOrderList.add(order);
    final status = fetchOrderStatus(order.id);
    final newStatus =
        OrderStatusData(orderId: order.id, status: OrderStatus.canceled);
    if (status == null) {
      addOrderStatus(newStatus);
    } else {
      updateOrderStatus(newStatus);
    }
  }

  @override
  Future<void> addDeliverdOrder(Order order) async {
    final List<Order> deliveredOrderList = [];
  }

  @override
  Future<void> addOrderStatus(OrderStatusData status) {
    // TODO: implement addOrderStatus
    throw UnimplementedError();
  }

  @override
  Future<void> deleteOrder(Order order) {
    final a = order;
    // TODO: implement deleteOrder
    throw UnimplementedError();
  }

  @override
  Future<OrderStatusData?> fetchOrderStatus(String orderId) {
    // TODO: implement fetchOrderStatus
    throw UnimplementedError();
  }

  @override
  Future<void> updateOrderStatus(OrderStatusData status) {
    // TODO: implement updateOrderStatus
    throw UnimplementedError();
  }
}
