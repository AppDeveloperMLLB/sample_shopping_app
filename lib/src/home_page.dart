import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/authentication/presentation/acount/account_page.dart';
import 'package:sample_shopping_app/src/features/cart/application/cart_application_service.dart';
import 'package:sample_shopping_app/src/features/cart/presentation/cart_item_controller.dart';
import 'package:sample_shopping_app/src/features/cart/presentation/shopping_cart_page.dart';
import 'package:sample_shopping_app/src/features/product_list/data/in_memory_product_repository.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/model/product.dart';
import 'package:sample_shopping_app/src/features/product_list/presentation/product_list_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  // 表示するページ
  static final List<Widget> _screens = [
    const ProductListPage(),
    const ShoppingCartPage(),
    const AccountPage(),
  ];

  // どのページを表示するか指定するindex
  int _selectedIndex = 0;

  // BottomNavigationBarタップ時のイベント
  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onTapped,
          fixedColor: Colors.blue,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: ShoppingCartIcon(), label: 'Cart'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'Account'),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.local_shipping), label: 'Delivery'),
            // BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Sample'),
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}

class ShoppingCartIcon extends ConsumerWidget {
  const ShoppingCartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemCount = ref.watch(cartItemsTotalCountProvider);
    return Badge(
      badgeContent: Text("$itemCount"),
      child: const Icon(
        Icons.shopping_cart,
      ),
    );
  }
}
