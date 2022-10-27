import 'package:path/path.dart';
import 'package:sample_shopping_app/src/features/authentication/domain/repository/authentication_reporisory.dart';
import 'package:sample_shopping_app/src/features/authentication/presentation/login/login_page.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/model/product.dart';
import 'package:sample_shopping_app/src/features/product_list/presentation/product_page.dart';
import 'package:sample_shopping_app/src/home_page.dart';
import 'package:sample_shopping_app/src/locator/repository_locator.dart';
import 'package:sample_shopping_app/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  home,
  product,
  cart,
  login,
  register,
}

class AppLocation {
  final String location;
  AppLocation({required this.location});
}

Map<AppRoute, AppLocation> appRoutes = {
  AppRoute.home: AppLocation(location: "/"),
  AppRoute.product: AppLocation(location: "/product"),
  AppRoute.cart: AppLocation(location: "/cart"),
  AppRoute.login: AppLocation(location: "/login"),
};

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository =
      RepositoryLocator.instance.get<AuthenticationRepository>();
  return GoRouter(
    initialLocation: appRoutes[AppRoute.home]?.location,
    debugLogDiagnostics: false,
    redirect: (state) {
      final isLoggedIn = authRepository.currentUser != null;
      if (isLoggedIn) {
        if (state.location == appRoutes[AppRoute.login]?.location) {
          return appRoutes[AppRoute.home]!.location;
        }
      } else {
        if (state.location != appRoutes[AppRoute.login]!.location) {
          return appRoutes[AppRoute.login]!.location;
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: appRoutes[AppRoute.login]!.location,
        name: AppRoute.login.name,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
          path: '/',
          name: AppRoute.home.name,
          builder: (context, state) => const BottomNavigationPage(),
          routes: [
            GoRoute(
              path: 'product',
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
          ]),
      // GoRoute(
      //   path: '/',
      //   name: AppRoute.home.name,
      //   builder: (context, state) => const ProductsListScreen(),
      //   routes: [
      //     GoRoute(
      //       path: 'product/:id',
      //       name: AppRoute.product.name,
      //       builder: (context, state) {
      //         final productId = state.params['id']!;
      //         return ProductScreen(productId: productId);
      //       },
      //       routes: [
      //         GoRoute(
      //           path: 'review',
      //           name: AppRoute.leaveReview.name,
      //           pageBuilder: (context, state) {
      //             final productId = state.params['id']!;
      //             return MaterialPage(
      //               key: state.pageKey,
      //               fullscreenDialog: true,
      //               child: LeaveReviewScreen(productId: productId),
      //             );
      //           },
      //         ),
      //       ],
      //     ),
      //     GoRoute(
      //       path: 'cart',
      //       name: AppRoute.cart.name,
      //       pageBuilder: (context, state) => MaterialPage(
      //         key: state.pageKey,
      //         fullscreenDialog: true,
      //         child: const ShoppingCartScreen(),
      //       ),
      //       routes: [
      //         GoRoute(
      //           path: 'checkout',
      //           name: AppRoute.checkout.name,
      //           pageBuilder: (context, state) => MaterialPage(
      //             key: ValueKey(state.location),
      //             fullscreenDialog: true,
      //             child: const CheckoutScreen(),
      //           ),
      //         ),
      //       ],
      //     ),
      //     GoRoute(
      //       path: 'orders',
      //       name: AppRoute.orders.name,
      //       pageBuilder: (context, state) => MaterialPage(
      //         key: state.pageKey,
      //         fullscreenDialog: true,
      //         child: const OrdersListScreen(),
      //       ),
      //     ),
      //     GoRoute(
      //       path: 'account',
      //       name: AppRoute.account.name,
      //       pageBuilder: (context, state) => MaterialPage(
      //         key: state.pageKey,
      //         fullscreenDialog: true,
      //         child: const AccountScreen(),
      //       ),
      //     ),
      //     GoRoute(
      //       path: 'signIn',
      //       name: AppRoute.signIn.name,
      //       pageBuilder: (context, state) => MaterialPage(
      //         key: state.pageKey,
      //         fullscreenDialog: true,
      //         child: const EmailPasswordSignInScreen(
      //           formType: EmailPasswordSignInFormType.signIn,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
