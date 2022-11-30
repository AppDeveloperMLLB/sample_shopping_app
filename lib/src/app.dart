import 'package:go_router/go_router.dart';
import 'package:sample_shopping_app/src/home_page.dart';
import 'package:sample_shopping_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      onGenerateTitle: (BuildContext context) => 'My Shop',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black, // foreground (text) color
          ),
        ),
      ),
    );
  }
}

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: ShoppingCartIcon(),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts),
            label: 'Delivery',
          ),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;
    if (location.startsWith(appRoutes[AppRoute.product]!.location)) {
      return 0;
    }
    if (location.startsWith(appRoutes[AppRoute.cart]!.location)) {
      return 1;
    }
    if (location.startsWith(appRoutes[AppRoute.account]!.location)) {
      return 2;
    }
    if (location.startsWith(appRoutes[AppRoute.order]!.location)) {
      return 3;
    }
    if (location.startsWith(appRoutes[AppRoute.delivery]!.location)) {
      return 4;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    String routeName = "";
    switch (index) {
      case 0:
        routeName = AppRoute.product.name;
        break;
      case 1:
        routeName = AppRoute.cart.name;
        break;
      case 2:
        routeName = AppRoute.account.name;
        break;
      case 3:
        routeName = AppRoute.order.name;
        break;
      case 4:
        routeName = AppRoute.delivery.name;
        break;
    }
    GoRouter.of(context).goNamed(routeName);
  }
}
