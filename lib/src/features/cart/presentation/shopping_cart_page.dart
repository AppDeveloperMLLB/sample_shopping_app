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
    // final productStreamProviderInCart = ref
    //     .read(shoppingCartPageControllerProvider.notifier)
    //     .getProductListStreamInCart();
    // final cartValue = ref.watch(productStreamProviderInCart);
    final cartValue = ref.watch(cartProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('カート'),
        ),
        body: SafeArea(
          child: Center(
            child: AsyncValueWidget(
              value: cartValue,
              data: (productList) {
                if(productList.isEmpty){
                  return const Text("商品がありません", style: TextStyle(fontSize: 16),);
                }
                return Column(
                  children: [
                    const Text(
                      "合計：10000円",
                      style: TextStyle(fontSize: 32),
                    ),
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
                      child: AsyncValueWidget(
                          value: cartValue,
                          data: (productList) {
                            return Scrollbar(
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return CartItem(
                                    product: productList[index].product,
                                    num: productList[index].num,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    thickness: 3,
                                  );
                                },
                                itemCount: productList.length,
                              ),
                            );
                          }),
                    ),
                    const Divider(
                      thickness: 3,
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}
