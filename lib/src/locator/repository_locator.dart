import 'package:sample_shopping_app/src/features/authentication/domain/repository/authentication_reporisory.dart';
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
  }) {
    _repositories.add(authenticationRepository);
    _repositories.add(productRepository);
  }

  T get<T>() {
    final index = _repositories.indexWhere((element) => element is T);
    if (index == -1) {
      throw Exception("The repository is not registered.");
    }

    return _repositories[index];
  }
}
