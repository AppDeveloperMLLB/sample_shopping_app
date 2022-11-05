import 'package:sample_shopping_app/src/features/cart/application/product_in_cart.dart';

class OrderData {
  final String userId;
  final DateTime dateTime;
  final List<ProductInCart> products;

  OrderData(
      {required this.userId, required this.dateTime, required this.products});
}
