import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/common_widgets/image_from_resource.dart';
import 'package:sample_shopping_app/src/constants/app_sizes.dart';
import 'package:sample_shopping_app/src/features/cart/presentation/cart_item_count_changer_widget.dart';
import 'package:sample_shopping_app/src/features/cart/presentation/shopping_cart_page_controller.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/model/product.dart';

class CartItem extends ConsumerWidget {
  final Product product;
  const CartItem({Key? key, required this.product}) : super(key: key);

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
            CartItemCountChangerWidget(
              productId: product.id,
            ),
            gapW8,
            IconButton(
                onPressed: () => ref
                    .read(shoppingCartPageControllerProvider.notifier)
                    .delete(product.id),
                icon: const Icon(Icons.delete))
          ],
        )
      ],
    );
  }
}
