import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/cart/application/cart_application_service.dart';
import 'package:sample_shopping_app/src/features/cart/domain/models/cart_item.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/model/product.dart';

final productPageControllerProvider =
    StateNotifierProvider<ProductPageController, AsyncValue<void>>((ref) {
  return ProductPageController();
});

class ProductPageController extends StateNotifier<AsyncValue<void>> {
  ProductPageController() : super(const AsyncData(null));

  Future<void> addCart(Product product, int num) async {
    final cartApplicationService = CartApplicationService();
    state = await AsyncValue.guard(() =>
        cartApplicationService.add(CartItem(productId: product.id, num: num)));
  }
}
