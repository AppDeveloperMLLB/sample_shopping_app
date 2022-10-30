import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/common_widgets/async_value_widget.dart';
import 'package:sample_shopping_app/src/features/cart/application/cart_application_service.dart';
import 'package:sample_shopping_app/src/features/cart/application/product_in_cart.dart';
import 'package:sample_shopping_app/src/features/cart/presentation/cart_item.dart';
import 'package:sample_shopping_app/src/features/cart/presentation/shopping_cart_page_controller.dart';

class ShoppingCartPage extends ConsumerWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(shoppingCartPageControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('カート'),
      ),
      body: SafeArea(
        child: Center(
          child: AsyncValueWidget(
            value: controller,
            data: (state) {
              return ProductListWidget();
            },
          ),
        ),
      ),
    );
  }
}

class ProductListWidget extends ConsumerWidget {
  const ProductListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final productsInCart = cart.value!;

    if(productsInCart.isEmpty){
      return  const Text(
        "商品がありません",
        style: TextStyle(fontSize: 16),
      );
    }

    return Column(
      children: [
        const CartTotalText(),
        ElevatedButton(
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              "レジに進む",
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
        const Divider(
          thickness: 3,
        ),
        Expanded(
          child: Scrollbar(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return CartItem(
                  product: productsInCart[index].product,
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 3,
                );
              },
              itemCount: productsInCart.length,
            ),
          ),
        ),
        const Divider(
          thickness: 3,
        ),
      ],
    );
  }
}

class CartTotalText extends ConsumerWidget {
  const CartTotalText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartTotal = ref.watch(cartTotalProvider);
    return Text(
      "合計：$cartTotal円",
      style: const TextStyle(fontSize: 32),
    );
  }
}
