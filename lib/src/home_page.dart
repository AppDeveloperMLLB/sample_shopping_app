import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/authentication/presentation/acount/account_page.dart';
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
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'Cart'),
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

// class SampleListPage extends ConsumerStatefulWidget {
//   const SampleListPage({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<SampleListPage> createState() => _SampleListPageState();
// }
//
// class _SampleListPageState extends ConsumerState<SampleListPage>
//     with TickerProviderStateMixin {
//   late AnimationController animationController;
//
//   @override
//   void initState() {
//     animationController = AnimationController(
//         duration: const Duration(milliseconds: 1000), vsync: this);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     animationController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final products = InMemoryProductRepository().products;
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text("Sample List"),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: products.length,
//         padding: const EdgeInsets.only(top: 8),
//         scrollDirection: Axis.vertical,
//         itemBuilder: (BuildContext context, int index) {
//           final int count = products.length > 10 ? 10 : products.length;
//           final Animation<double> animation =
//               Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//                   parent: animationController!,
//                   curve: Interval((1 / count) * index, 1.0,
//                       curve: Curves.fastOutSlowIn)));
//           animationController?.forward();
//           return SampleListView(
//             callback: () {},
//             product: products[index],
//             animation: animation,
//             animationController: animationController!,
//           );
//         },
//       ),
//     );
//   }
// }
//
// class SampleListView extends StatelessWidget {
//   const SampleListView({
//     Key? key,
//     required this.callback,
//     required this.product,
//     required this.animationController,
//     required this.animation,
//   }) : super(key: key);
//
//   final VoidCallback? callback;
//   final Product product;
//   final AnimationController? animationController;
//   final Animation<double>? animation;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animationController!,
//       builder: (BuildContext context, Widget? child) {
//         return FadeTransition(
//           opacity: animation!,
//           child: Transform(
//             transform: Matrix4.translationValues(
//                 0.0, 50 * (1.0 - animation!.value), 0.0),
//             child:
//           ),
//         );
//       },
//     );
//   }
// }
