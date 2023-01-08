import 'package:sample_shopping_app/src/features/order/domain/repository/order_repository.dart';

class OrderDataForOrderList {
  final String userId;
  final DateTime dateTime;
  final String productName;
  final int productPrice;
  final String imageResource;
  final OrderStatus status;

  OrderDataForOrderList({
    required this.userId,
    required this.dateTime,
    required this.productName,
    required this.productPrice,
    required this.imageResource,
    required this.status,
  });
}
