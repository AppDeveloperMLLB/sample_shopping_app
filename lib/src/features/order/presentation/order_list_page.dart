  import 'package:flutter/material.dart';
import 'package:sample_shopping_app/src/features/order/presentation/order_list.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("注文一覧"),),
      body: const SafeArea(
        child: OrderList(),
      ),
    );
  }
}

