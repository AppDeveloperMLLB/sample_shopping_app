import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/model/product.dart';
import 'package:sample_shopping_app/src/features/product_list/presentation/product_page_controller.dart';
import 'package:sample_shopping_app/src/utils/async_value_ui.dart';

class ProductPage extends ConsumerWidget {
  final Product product;
  const ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(productPageControllerProvider, (_, next) {
      next.showAlertDialogOnError(
        context,
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(
                product.name,
                style: TextStyle(fontSize: 24),
              ),
              ElevatedButton(
                  onPressed: () {
                    ref
                        .read(productPageControllerProvider.notifier)
                        .addCart(product, 1);
                  },
                  child: Text("Add to cart")),
            ],
          ),
        ),
      ),
    );
  }
}
