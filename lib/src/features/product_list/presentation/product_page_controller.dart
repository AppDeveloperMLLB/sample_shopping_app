import 'package:flutter/animation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/cart/application/cart_application_service.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/model/product.dart';

final productPageControllerProvider =
    StateNotifierProvider.autoDispose<ProductPageController, AsyncValue<void>>(
        (ref) {
  return ProductPageController();
});

class ProductPageController extends StateNotifier<AsyncValue<void>> {
  ProductPageController() : super(const AsyncData(null));

  Future<void> addCart(
      {required Product product,
      required int num,
      required VoidCallback onSuccess}) async {
    state = const AsyncLoading();
    final cartApplicationService = CartApplicationService();
    state = await AsyncValue.guard(
        () => cartApplicationService.add(productId: product.id, num: num));
    if (state.hasError) return;
    onSuccess.call();
  }
}
