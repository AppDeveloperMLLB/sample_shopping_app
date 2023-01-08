import 'package:sample_shopping_app/src/features/order/domain/repository/order_repository.dart';

class OrderData {
  final String orderId;
  final OrderStatus orderStatus;

  OrderData({required this.orderId, required this.orderStatus});
}
