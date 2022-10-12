import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/cart/application/cart_application_service.dart';
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
  ShoppingCartPageControllerProvider() : super(const AsyncValue.loading());

  StreamProvider<List<Product>> getProductListStreamInCart() {
    final cartApplicationService = CartApplicationService();
    return cartApplicationService.watchCart();
  }
}
