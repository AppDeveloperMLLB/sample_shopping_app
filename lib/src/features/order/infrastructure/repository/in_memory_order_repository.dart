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
  Future<void> addUndeliveredOrder(Order order) async {
    _undeliveedOrderList.add(order);
    _order.value = _undeliveedOrderList.toList();
    updateOrderValue();
  }

  void updateOrderValue() {
    _order.value = [..._undeliveedOrderList, ..._deliveredOrderList];
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
    _deliveredOrderList.add(order);
    updateOrderValue();
  }

  @override
  Future<void> addOrderStatus(OrderStatusData status) async {
    _orderStatusDataList.add(status);
  }

  @override
  Future<void> deleteUndeliveredOrder(Order order) async {
    final index =
        _undeliveedOrderList.indexWhere((element) => element.id == order.id);
    _undeliveedOrderList.removeAt(index);
    updateOrderValue();
  }

  @override
  Future<OrderStatusData?> fetchOrderStatus(String orderId) async {
    final index = _orderStatusDataList
        .indexWhere((element) => element.orderId == orderId);
    if (index >= 0) {
      return _orderStatusDataList[index];
    }

    return null;
  }

  @override
  Future<void> updateOrderStatus(OrderStatusData status) async {
    final index = _orderStatusDataList
        .indexWhere((element) => element.orderId == status.orderId);
    if (index == -1) {
      throw Exception("OrderStatus is not exists");
    }

    _orderStatusDataList[index] = status;
  }

  @override
  Future<Order?> fetchUndeliveredOrder(String orderId) async {
    final index =
        _undeliveedOrderList.indexWhere((element) => element.id == orderId);
    if (index == -1) return null;
    return _undeliveedOrderList[index];
  }
}
