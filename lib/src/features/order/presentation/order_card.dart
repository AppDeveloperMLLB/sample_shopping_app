import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/order/application/order_application_service.dart';

class OrderCard extends ConsumerWidget {
  final String orderId;
  const OrderCard({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderListProvider.select((value) =>
        value.value!.firstWhere((element) => element.id == orderId)));
    return Column(
      children: [
        Text(orderId),
        Text(order.date.toString()),
        Text(order.productId),
      ],
    );
  }
}
