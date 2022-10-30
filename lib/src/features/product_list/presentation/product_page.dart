import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/common_widgets/async_value_widget.dart';
import 'package:sample_shopping_app/src/common_widgets/image_from_resource.dart';
import 'package:sample_shopping_app/src/constants/app_sizes.dart';
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

    final state = ref.watch(productPageControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
      ),
      body: SafeArea(
        child: Center(
          child: AsyncValueWidget(
            data: (value){
              return Column(
                children: [
                  gapH8,
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ImageFromResource(
                      resource: product.imageResource,
                    ),
                  ),
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 24),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        ref
                            .read(productPageControllerProvider.notifier)
                            .addCart(
                          product: product,
                          num: 1,
                          onSuccess: () => Navigator.of(context).pop(),
                        );
                      },
                      child: Text("Add to cart")),
                ],
              );
            },
            value: state,
          ),
        ),
      ),
    );
  }
}
