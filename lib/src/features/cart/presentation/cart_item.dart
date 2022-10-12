import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/common_widgets/image_from_resource.dart';
import 'package:sample_shopping_app/src/constants/app_sizes.dart';
import 'package:sample_shopping_app/src/features/cart/domain/models/cart_item.dart';
import 'package:sample_shopping_app/src/features/cart/presentation/cart_item_controller.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/model/product.dart';

class CartItem extends ConsumerWidget {
  final Product product;
  final int num;
  const CartItem({Key? key, required this.product, required this.num})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ImageFromResource(
                    resource: product.imageResource,
                  ),
                )),
            Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Text(product.name),
                    Text(product.price.toString())
                  ],
                ))
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  ref
                      .read(cartItemControllerProvider.notifier)
                      .decrement(product.id);
                },
                icon: const Icon(Icons.remove)),
            Text(num.toString()),
            IconButton(
                onPressed: () => ref
                    .read(cartItemControllerProvider.notifier)
                    .increment(product.id),
                icon: const Icon(Icons.add)),
            gapW8,
            IconButton(
                onPressed: () => ref
                    .read(cartItemControllerProvider.notifier)
                    .delete(product.id),
                icon: const Icon(Icons.delete))
          ],
        )
      ],
    );
  }
}
