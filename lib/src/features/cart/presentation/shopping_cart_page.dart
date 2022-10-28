import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/common_widgets/async_value_widget.dart';
import 'package:sample_shopping_app/src/constants/app_sizes.dart';
import 'package:sample_shopping_app/src/features/cart/application/cart_application_service.dart';
import 'package:sample_shopping_app/src/features/cart/presentation/cart_item.dart';
import 'package:sample_shopping_app/src/features/cart/presentation/shopping_cart_page_controller.dart';
import 'package:sample_shopping_app/src/routing/app_router.dart';

class ShoppingCartPage extends ConsumerWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBar = AppBar(
      title: const Text('カート'),
    );

    final isEmpty = ref.watch<bool>(
        cartProvider.select((value) => (value.value?.length ?? 0) == 0));

    if (isEmpty) {
      return Scaffold(
        appBar: appBar,
        body: const SafeArea(
          child: Center(
            child: Text(
              "商品がありません",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('カート'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
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
              const Expanded(
                child: ProductListWidget(),
              ),
              const Divider(
                thickness: 3,
              ),
            ],
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
    final productListInCart = ref.watch(cartProvider
        .select((value) => value.value!.map((e) => e.product).toList()));
    // return AsyncValueWidget(
    //     value: cartValue,
    //     data: (productList) {
    return Scrollbar(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return CartItem(
            product: productListInCart[index],
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 3,
          );
        },
        itemCount: productListInCart.length,
      ),
    );
    // });
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
