import 'package:sample_shopping_app/src/app.dart';
import 'package:sample_shopping_app/src/features/authentication/domain/model/user.dart';
import 'package:sample_shopping_app/src/features/authentication/domain/repository/authentication_reporisory.dart';
import 'package:sample_shopping_app/src/features/authentication/presentation/acount/account_page.dart';
import 'package:sample_shopping_app/src/features/authentication/presentation/login/login_page.dart';
import 'package:sample_shopping_app/src/features/cart/presentation/shopping_cart_page.dart';
import 'package:sample_shopping_app/src/features/delivery/presentation/delivery_manager_page.dart';
import 'package:sample_shopping_app/src/features/order/presentation/order_list_page.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/model/product.dart';
import 'package:sample_shopping_app/src/features/product_list/presentation/product_page.dart';
import 'package:sample_shopping_app/src/locator/repository_locator.dart';
import 'package:sample_shopping_app/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  product,
  cart,
  account,
  order,
  delivery,
  login,
}

class AppLocation {
  final String location;
  AppLocation({required this.location});
}

Map<AppRoute, AppLocation> appRoutes = {
  AppRoute.product: AppLocation(location: "/product"),
  AppRoute.cart: AppLocation(location: "/cart"),
  AppRoute.account: AppLocation(location: "/account"),
  AppRoute.order: AppLocation(location: "/order"),
  AppRoute.delivery: AppLocation(location: "/delivery"),
  AppRoute.login: AppLocation(location: "/login"),
};

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository =
      RepositoryLocator.instance.get<AuthenticationRepository>();
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: appRoutes[AppRoute.login]?.location,
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      if (isLoggedIn) {
        if (state.location == appRoutes[AppRoute.login]?.location) {
          return appRoutes[AppRoute.product]!.location;
        }
      } else {
        if (state.location != appRoutes[AppRoute.login]!.location) {
          return appRoutes[AppRoute.login]!.location;
        }
      }
      return null;
    },
    refreshListenable: ref.listen(provider, (previous, next) { }),
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => ScaffoldWithNavBar(child: child),
        routes: <RouteBase>[
          // Product
          GoRoute(
            path: appRoutes[AppRoute.product]!.location,
            name: AppRoute.product.name,
            pageBuilder: (context, state) {
              final product = state.extra! as Product;
              return MaterialPage(
                child: ProductPage(
                  product: product,
                ),
              );
            },
          ),
          // Cart
          GoRoute(
            path: appRoutes[AppRoute.cart]!.location,
            name: AppRoute.cart.name,
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: ShoppingCartPage(),
              );
            },
          ),
          // Account,
          GoRoute(
            path: appRoutes[AppRoute.account]!.location,
            name: AppRoute.account.name,
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: AccountPage(),
              );
            },
          ),
          // delivery,
          GoRoute(
            path: appRoutes[AppRoute.delivery]!.location,
            name: AppRoute.delivery.name,
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: DeliveryManagerPage(),
              );
            },
          ),
          // Order
          GoRoute(
            path: appRoutes[AppRoute.order]!.location,
            name: AppRoute.order.name,
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: OrderListPage(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: appRoutes[AppRoute.login]!.location,
        name: AppRoute.login.name,
        builder: (context, state) => const LoginPage(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});

class _AuthStateNotifier extends ValueNotifier<User?> {
  _AuthStateNotifier() : super(null);
  void change(User? v) => value = v;
}

final authStateNotifier = _AuthStateNotifier();

final authProvider = StreamProvider<User?>(
  (ref) {
    final authRepository =
        RepositoryLocator.instance.get<AuthenticationRepository>();
    ref.listenSelf((_, v) => authStateNotifier.change(v.value));
    return authRepository.authStateChanges();
  },
);

final sampleProvider = NotifierProvider<Sample, User?>(() => Sample());

class Sample extends Notifier<User?> {
  @override
  User? build() {
    return null;
  }
}
final a = ChangeNotifierProvider(((ref) {
  ref.listen(, (previous, next) { 

        final authRepository =
        RepositoryLocator.instance.get<AuthenticationRepository>();
    authRepository.authStateChanges().listen((event) {
      
    })
  })
});
// ignore: camel_case_types
class ChangeSample extends ChangeNotifier {
  User? _loginUser;
  void update(User? user){
    _loginUser = user;
    notifyListeners();
  }
}
