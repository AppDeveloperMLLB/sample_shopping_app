import 'package:flutter/material.dart';
import 'package:sample_shopping_app/src/features/delivery/domain/delivery_status.dart';

class DeliveryManagerPage extends StatelessWidget {
  const DeliveryManagerPage({super.key});

  final List<String> _list = const ["aaa", "bbb", "ccc", "ddd", "eeee"];
  @override
  Widget build(BuildContext context) {
    final a = DeliveryStatus.values
        .map((e) => DropdownMenuItem<DeliveryStatus>(
              value: e,
              child: Text(e.name),
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(title: const Text("Delivery Management")),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    _list[index],
                    style: const TextStyle(fontSize: 36),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: DropdownButton(
                    items: DeliveryStatus.values
                        .map((e) => DropdownMenuItem<DeliveryStatus>(
                              value: e,
                              child: Text(e.name),
                            ))
                        .toList(),
                    onChanged: (DeliveryStatus? value) {},
                    value: DeliveryStatus.undelivered,
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
          itemCount: _list.length,
        ),
      ),
    );
  }
}
