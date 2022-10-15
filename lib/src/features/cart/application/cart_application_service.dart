import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/cart/application/product_in_cart.dart';
import 'package:sample_shopping_app/src/features/cart/domain/models/cart_item.dart';
import 'package:sample_shopping_app/src/features/cart/domain/repository/cart_repository.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/model/product.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/repository/product_repository.dart';
import 'package:sample_shopping_app/src/locator/repository_locator.dart';
import 'package:sample_shopping_app/src/utils/in_memory_store.dart';

class CartApplicationService {
  final CartRepository cartRepository =
      RepositoryLocator.instance.get<CartRepository>();

  StreamProvider<List<ProductInCart>> watchCart() {
    return StreamProvider<List<ProductInCart>>((ref) {
      return cartRepository.watchCart();
    });
  }

  Future<void> add(CartItem cartItem) async {
    await cartRepository.add(cartItem);
  }

  Future<void> delete(String productId) async {
    await cartRepository.delete(productId);
  }

  Future<List<ProductInCart>> getProductsInCart() async {
    final cartItems = await cartRepository.getAllItemsInCart();

    final productRepository =
        RepositoryLocator.instance.get<ProductRepository>();
    final List<ProductInCart> productList = [];
    cartItems.map((e) async {
      final product = await productRepository.fetch(e.productId);
      final productInCart = ProductInCart(product: product, num: e.num);
      productList.add(productInCart);
    });
    return productList;
  }

  Future<void> increment(String productId) async {
    final cartItem = await cartRepository.getCartItem(productId);
    cartItem.increment();
    await cartRepository.update(cartItem);
  }

  Future<void> decrement(String productId) async {
    final cartItem = await cartRepository.getCartItem(productId);
    cartItem.decrement();
    await cartRepository.update(cartItem);
  }
}

final cartProvider = StreamProvider<List<ProductInCart>>((ref) {
  final CartRepository cartRepository = RepositoryLocator.instance.get<CartRepository>();
  return cartRepository.watchCart();
});

final cartTotalProvider = Provider<int>((ref) {
  final productsInCart = ref.watch(cartProvider).value;
  if(productsInCart == null || productsInCart.isEmpty) {
    return 0;
  }

  int total = 0;
  for(final productInCart in productsInCart){
    total += productInCart.product.price;
  }
  return total;
});
