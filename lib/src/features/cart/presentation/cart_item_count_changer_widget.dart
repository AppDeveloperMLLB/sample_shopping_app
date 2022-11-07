import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/cart/application/cart_application_service.dart';
import 'package:sample_shopping_app/src/features/cart/presentation/shopping_cart_page_controller.dart';

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
                  .read(shoppingCartPageControllerProvider.notifier)
                  .decrement(productId);
            },
            icon: const Icon(Icons.remove)),
        CartItemCountText(
          productId: productId,
        ),
        IconButton(
            onPressed: () => ref
                .read(shoppingCartPageControllerProvider.notifier)
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
        if(value.value == null || value.value!.isEmpty){
          return 0;
        }

        return value.value!
            .firstWhere((element) => element.product.id == productId)
            ?.num;
      },
    ));
    return Text("${state ?? 1}");
  }
}
