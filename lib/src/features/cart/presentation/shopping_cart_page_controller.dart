import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/cart/application/cart_application_service.dart';
import 'package:sample_shopping_app/src/features/cart/application/product_in_cart.dart';
import 'package:sample_shopping_app/src/features/cart/domain/repository/cart_repository.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/model/product.dart';
import 'package:sample_shopping_app/src/locator/repository_locator.dart';

final shoppingCartPageControllerProvider =
    StateNotifierProvider<ShoppingCartPageControllerProvider, AsyncValue<void>>(
        (ref) {
  return ShoppingCartPageControllerProvider();
});

class ShoppingCartPageControllerProvider
    extends StateNotifier<AsyncValue<void>> {
  ShoppingCartPageControllerProvider() : super(const AsyncData(null));

  StreamProvider<List<ProductInCart>> getProductListStreamInCart() {
    final cartApplicationService = CartApplicationService();
    return cartApplicationService.watchCart();
  }

  Future<void> delete(String productId) async {
    final service = CartApplicationService();
    state = await AsyncValue.guard(() => service.delete(productId));
  }

  Future<void> increment(String productId) async {
    state = const AsyncLoading();
    final service = CartApplicationService();
    state = await AsyncValue.guard(() => service.increment(productId));
  }

  Future<void> decrement(String productId) async {
    state = const AsyncLoading();
    final service = CartApplicationService();
    state = await AsyncValue.guard(() => service.decrement(productId));
  }
}
