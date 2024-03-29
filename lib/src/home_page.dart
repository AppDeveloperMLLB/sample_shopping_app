import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/authentication/presentation/acount/account_page.dart';
import 'package:sample_shopping_app/src/features/cart/application/cart_application_service.dart';
import 'package:sample_shopping_app/src/features/cart/presentation/shopping_cart_page.dart';
import 'package:sample_shopping_app/src/features/delivery/presentation/delivery_manager_page.dart';
import 'package:sample_shopping_app/src/features/order/presentation/order_list_page.dart';
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
    const OrderListPage(),
    const DeliveryManagerPage(),
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
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
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
      label: Text("$itemCount"),
      child: const Icon(
        Icons.shopping_cart,
      ),
    );
  }
}
