import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/cart/application/cart_application_service.dart';
import 'package:sample_shopping_app/src/features/cart/presentation/cart_item_count_change_controller.dart';

import 'cart_item_controller.dart';

class CartItemCountChangerWidget extends ConsumerWidget {
  final String productId;
  const CartItemCountChangerWidget({Key? key, required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              ref
                  .read(cartItemControllerProvider.notifier)
                  .decrement(productId);
            },
            icon: const Icon(Icons.remove)),
        CartItemCountText(
          productId: productId,
        ),
        IconButton(
            onPressed: () => ref
                .read(cartItemControllerProvider.notifier)
                .increment(productId),
            icon: const Icon(Icons.add)),
      ],
    );
  }
}

class CartItemCountText extends ConsumerWidget {
  final String productId;
  const CartItemCountText({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cartProvider.select(
      (value) {
        return value.value!
            .firstWhere((element) => element.product.id == productId)
            ?.num;
      },
    ));
    return Text("${state ?? 1}");
  }
}
