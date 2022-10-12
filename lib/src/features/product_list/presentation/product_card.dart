import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_shopping_app/src/common_widgets/image_from_resource.dart';
import 'package:sample_shopping_app/src/constants/app_sizes.dart';
import '../domain/model/product.dart';

class ProductCard extends ConsumerWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: InkWell(
        onTap: () {
          context.goNamed("product", extra: product);
        },
        child: Column(
          children: [
            ImageFromResource(
              resource: product.imageResource,
            ),
            gapH8,
            Text(
              product.name,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text("${product.price}円"),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
