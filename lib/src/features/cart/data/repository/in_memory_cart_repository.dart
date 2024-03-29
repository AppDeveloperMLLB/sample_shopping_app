import 'package:sample_shopping_app/src/features/cart/application/product_in_cart.dart';
import 'package:sample_shopping_app/src/features/cart/domain/models/cart_item.dart';
import 'package:sample_shopping_app/src/features/cart/domain/repository/cart_repository.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/repository/product_repository.dart';
import 'package:sample_shopping_app/src/locator/repository_locator.dart';
import 'package:sample_shopping_app/src/utils/in_memory_store.dart';

class InCartRepository implements CartRepository {
  InCartRepository._();
  static final instance = InCartRepository._();
  final _cart = InMemoryStore<List<ProductInCart>>([]);
  final List<CartItem> _cartItems = [];

  @override
  Stream<List<ProductInCart>> watchCart() {
    return _cart.stream;
  }

  @override
  Future<void> add(CartItem item) async {
    if (_cart.value.any((element) => element.product.id == item.productId)) {
      throw Exception("Failed to add product in cart");
    }

    _cartItems.add(item);
    final productRepository =
        RepositoryLocator.instance.get<ProductRepository>();
    final product = await productRepository.fetch(item.productId);
    final List<ProductInCart> newList = [];
    _cart.value.asMap().forEach((i, element) {
      newList.add(element);
    });
    newList.add(ProductInCart(product: product, num: item.num));
    _cart.value = newList;
  }

  @override
  Future<void> delete(String userId, String productId) async {
    final index = _cartItems.indexWhere((element) =>
        element.userId == userId && element.productId == productId);
    if (index == -1) {
      throw Exception("Failed to delete product in cart");
    }
    _cartItems.removeAt(index);
    _cart.value.removeWhere((element) => element.product.id == productId);
  }

  @override
  Future<void> deleteAll(String userId) async {
    _cartItems.removeWhere((element) => element.userId == userId);
    _cart.value = await toProductInCart(_cartItems);
  }

  Future<List<ProductInCart>> toProductInCart(List<CartItem> cartItems) async {
    List<ProductInCart> ret = [];
    final productRepo = RepositoryLocator.instance.get<ProductRepository>();

    for (final item in cartItems) {
      final product = await productRepo.fetch(item.productId);
      ret.add(ProductInCart(product: product, num: item.num));
    }

    return ret;
  }

  @override
  Future<CartItem> getCartItem(String productId) async {
    final index =
        _cartItems.indexWhere((element) => element.productId == productId);
    if (index == -1) {
      throw Exception("Failed to get product in cart");
    }
    return _cartItems[index];
  }

  @override
  Future<List<CartItem>> getAllItemsInCart() async {
    return _cartItems;
  }

  @override
  Future<void> update(CartItem item) async {
    await Future.delayed(const Duration(seconds: 2));
    final index =
        _cartItems.indexWhere((element) => element.productId == item.productId);
    if (index == -1) {
      throw Exception("Failed to update product in cart");
    }
    _cartItems[index] = item;

    final productRepository =
        RepositoryLocator.instance.get<ProductRepository>();
    final product = await productRepository.fetch(item.productId);
    final List<ProductInCart> newList = [];
    _cart.value.asMap().forEach((i, element) {
      if (index == i) {
        newList.add(ProductInCart(product: product, num: item.num));
        return;
      }

      newList.add(element);
    });
    _cart.value = newList;
  }
}
