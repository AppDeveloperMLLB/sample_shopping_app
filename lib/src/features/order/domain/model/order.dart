class Order {
  final String id;
  final String userId;
  final DateTime date;
  final String productId;
  final int num;

  Order({
    required this.id,
    required this.userId,
    required this.date,
    required this.productId,
    required this.num,
  });
}
