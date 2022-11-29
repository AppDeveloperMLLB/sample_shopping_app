import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sample_shopping_app/src/common_widgets/image_from_resource.dart';
import 'package:sample_shopping_app/src/features/order/application/order_data.dart';

class OrderCard extends ConsumerWidget {
  final OrderDataForOrderList orderData;
  const OrderCard({Key? key, required this.orderData}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dtFormat = DateFormat("yy-MM-dd HH:mm:ss");
    return GestureDetector(
      onTap: () {
        // TODO: think this details is need;
        //context.goNamed(AppRoute.order, extra: orderData);
      },
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: ImageFromResource(
              resource: orderData.imageResource,
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("商品名：${orderData.productName}"),
                  ],
                ),
                Text("商品名：${orderData.productName}"),
                Text("商品金額：${orderData.productPrice}"),
                Text("注文日時：${dtFormat.format(orderData.dateTime)}"),
                const Text("注文状況：配達中"),
              ],
            ),
          ),
          // const Expanded(
          //   flex: 1,
          //   child: Icon(Icons.arrow_forward_ios),
          // ),
        ],
      ),
    );
  }
}
