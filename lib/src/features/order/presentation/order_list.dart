import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/order/application/order_application_service.dart';
import 'package:sample_shopping_app/src/features/order/presentation/order_card.dart';
import 'package:sample_shopping_app/src/features/order/presentation/order_list_controller.dart';

class OrderList extends ConsumerWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderIdList = ref.watch(orderListControllerProvider);
    // TODO: 注文は一つずつ、一つずつ表示、詳細に移動
    return ListView.builder(
      itemBuilder: (context, index) {
        return OrderCard(orderId: orderIdList.value![index]);
      },
      itemCount: orderIdList.value!.length,
    );
  }
}
