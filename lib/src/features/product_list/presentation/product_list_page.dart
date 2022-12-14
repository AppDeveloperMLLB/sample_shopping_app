import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/model/product.dart';
import 'package:sample_shopping_app/src/features/product_list/presentation/product_card.dart';
import 'package:sample_shopping_app/src/routing/app_router.dart';

import '../data/in_memory_product_repository.dart';

class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductListPage> createState() => _SampleListPageState();
}

class _SampleListPageState extends ConsumerState<ProductListPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = InMemoryProductRepository().products;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Sample List"),
        ),
      ),
      body: ListView.builder(
        itemCount: products.length,
        padding: const EdgeInsets.only(top: 8),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          final int count = products.length > 10 ? 10 : products.length;
          final Animation<double> animation =
              Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: animationController,
                  curve: Interval((1 / count) * index, 1.0,
                      curve: Curves.fastOutSlowIn)));
          animationController.forward();
          return SampleListView(
            callback: (Product product) => onProductTapped(product),
            product: products[index],
            animation: animation,
            animationController: animationController,
          );
        },
      ),
    );
  }

  void onProductTapped(Product product) {
    context.goNamed(AppRoute.product.name, extra: product);
  }
}

class SampleListView extends StatelessWidget {
  const SampleListView({
    Key? key,
    required this.callback,
    required this.product,
    required this.animationController,
    required this.animation,
  }) : super(key: key);

  final void Function(Product product) callback;
  final Product product;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: ProductCard(
              product: product,
              onTapped: callback,
            ),
          ),
        );
      },
    );
  }
}
