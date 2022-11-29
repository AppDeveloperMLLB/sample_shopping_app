import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/common_widgets/async_value_widget.dart';
import 'package:sample_shopping_app/src/features/order/application/order_application_service.dart';
import 'package:sample_shopping_app/src/features/order/presentation/order_card.dart';
import 'package:sample_shopping_app/src/features/order/presentation/order_list_controller.dart';

class OrderList extends ConsumerWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderList = ref.watch(orderDataListProvider);
    return Center(
      child: AsyncValueWidget(
        value: orderList,
        data: (orderDataList) {
          if (orderDataList.isEmpty) {
            return const Text("注文履歴なし");
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              return OrderCard(orderData: orderDataList[index]);
            },
            separatorBuilder: (context, index){
              return const Divider(thickness: 3,);
            },
            itemCount: orderDataList.length,
          );
        },
      ),
    );
  }
}
