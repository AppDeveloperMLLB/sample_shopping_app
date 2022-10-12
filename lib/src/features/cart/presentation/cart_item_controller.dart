import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/cart/application/cart_application_service.dart';
import 'package:sample_shopping_app/src/features/cart/domain/repository/cart_repository.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/model/product.dart';
import 'package:sample_shopping_app/src/locator/repository_locator.dart';

final cartItemControllerProvider =
    StateNotifierProvider<CartItemControllerProvider, AsyncValue<void>>((ref) {
  return CartItemControllerProvider();
});

class CartItemControllerProvider extends StateNotifier<AsyncValue<void>> {
  CartItemControllerProvider() : super(const AsyncValue.loading());

  Future<void> increment(String productId) async {
    final service = CartApplicationService();
    state = await AsyncValue.guard(() => service.increment(productId));
  }

  Future<void> decrement(String productId) async {
    final service = CartApplicationService();
    state = await AsyncValue.guard(() => service.decrement(productId));
  }

  Future<void> delete(String productId) async {
    final service = CartApplicationService();
    state = await AsyncValue.guard(() => service.delete(productId));
  }
}
