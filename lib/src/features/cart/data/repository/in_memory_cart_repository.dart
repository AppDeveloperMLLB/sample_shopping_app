import 'package:sample_shopping_app/src/features/cart/application/product_in_cart.dart';
import 'package:sample_shopping_app/src/features/cart/domain/models/cart_item.dart';
import 'package:sample_shopping_app/src/features/cart/domain/repository/cart_repository.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/model/product.dart';
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
    _cart.value.add(ProductInCart(product: product, num: item.num));
  }

  @override
  Future<void> delete(String productId) async {
    final index =
        _cartItems.indexWhere((element) => element.productId == productId);
    if (index == -1) {
      throw Exception("Failed to delete product in cart");
    }
    _cartItems.removeAt(index);
    _cart.value.removeWhere((element) => element.product.id == productId);
  }

  @override
  Future<void> deleteAll() async {
    // TODO: implement deleteAll
    throw UnimplementedError();
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
    final index =
        _cartItems.indexWhere((element) => element.productId == item.productId);
    if (index == -1) {
      throw Exception("Failed to update product in cart");
    }
    _cartItems[index] = item;
  }
}
