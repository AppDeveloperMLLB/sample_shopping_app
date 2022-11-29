import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/delivery/domain/delivery_status.dart';

class OrderCard extends ConsumerWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Expanded(
          flex: 7,
          child: Text(
            "aaaa",
            style: TextStyle(fontSize: 36),
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
  }
}
