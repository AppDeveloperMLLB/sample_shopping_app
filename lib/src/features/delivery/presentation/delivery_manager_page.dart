import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/common_widgets/async_value_widget.dart';
import 'package:sample_shopping_app/src/features/delivery/domain/delivery_status.dart';
import 'package:sample_shopping_app/src/features/delivery/presentation/delivery_manager_controller.dart';
import 'package:sample_shopping_app/src/features/delivery/presentation/order_data.dart';
import 'package:sample_shopping_app/src/features/order/domain/repository/order_repository.dart';

class DeliveryManagerPage extends ConsumerWidget {
  const DeliveryManagerPage({super.key});

  DeliveryStatus parse(OrderStatus status) {
    switch (status) {
      case OrderStatus.canceled:
        throw Exception();
      case OrderStatus.undelivered:
        return DeliveryStatus.undelivered;
      case OrderStatus.delivered:
        return DeliveryStatus.delivered;
      default:
        throw Exception();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final a = DeliveryStatus.values
        .map((e) => DropdownMenuItem<DeliveryStatus>(
              value: e,
              child: Text(e.name),
            ))
        .toList();
    final orderAsyncValue = ref.watch(orderDataListProvider);
    return AsyncValueWidget(
      value: orderAsyncValue,
      data: (List<OrderData> orderDataList) {
        return Scaffold(
          appBar: AppBar(title: const Text("Delivery Management")),
          body: Center(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final orderData = orderDataList[index];
                return Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Text(
                        orderData.orderId,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: DropdownButton(
                        items: DeliveryStatus.values
                            .map((e) => DropdownMenuItem<DeliveryStatus>(
                                  value: e,
                                  child: Text(e.displayName),
                                ))
                            .toList(),
                        onChanged: (DeliveryStatus? value) {
                          ref
                              .read(deliveryManagerControllerProvider.notifier)
                              .changeDeliveryState(orderData.orderId, value!);
                        },
                        value: parse(orderData.orderStatus),
                      ),
                    )
                  ],
                );
                // return Slidable(
                //   key: ValueKey(_list[index]),
                //   endActionPane: ActionPane(
                //     extentRatio: 0.2,
                //     motion: const StretchMotion(), // (5)
                //     dismissible: DismissiblePane(onDismissed: () {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(
                //           content: Text('message dismissed'),
                //         ),
                //       );
                //     }),
                //     children: [
                //       SlidableAction(
                //         onPressed: (_) {
                //           print("aaaa");
                //         },
                //         backgroundColor: Theme.of(context).primaryColor,
                //         icon: Icons.delivery_dining,
                //         label: 'Delivery',
                //       ),
                //     ],
                //   ),
                //   child: SizedBox(
                //       width: MediaQuery.of(context).size.width,
                //       child: Text(_list[index])),
                // );
              },
              itemCount: orderDataList.length,
            ),
          ),
        );
      },
    );
  }
}
