import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/cart/application/cart_application_service.dart';

final cartItemCountChangerWidgetControllerProvider = StateNotifierProvider<
    CartItemCountChangerWidgetController, AsyncValue<void>>((ref) {
  return CartItemCountChangerWidgetController();
});

class CartItemCountChangerWidgetController
    extends StateNotifier<AsyncValue<void>> {
  CartItemCountChangerWidgetController() : super(const AsyncData(null));
}
