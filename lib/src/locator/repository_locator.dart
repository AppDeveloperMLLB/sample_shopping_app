import 'package:sample_shopping_app/src/features/authentication/domain/repository/authentication_reporisory.dart';
import 'package:sample_shopping_app/src/features/cart/domain/repository/cart_repository.dart';
import 'package:sample_shopping_app/src/features/order/domain/repository/order_repository.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/repository/product_repository.dart';

class RepositoryLocator {
  final _repositories = [];

  RepositoryLocator._();
  static final instance = RepositoryLocator._();

  void add<T>(T repository) {
    _repositories.add(repository);
  }

  void addAll({
    required AuthenticationRepository authenticationRepository,
    required ProductRepository productRepository,
    required CartRepository cartRepository,
    required OrderRepository orderRepository,
  }) {
    _repositories.add(authenticationRepository);
    _repositories.add(productRepository);
    _repositories.add(cartRepository);
    _repositories.add(orderRepository);
  }

  T get<T>() {
    final index = _repositories.indexWhere((element) => element is T);
    if (index == -1) {
      throw Exception("The repository is not registered.");
    }

    return _repositories[index];
  }
}
