import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/app.dart';
import 'package:sample_shopping_app/src/features/authentication/data/repository/in_memory_authentication_repository.dart';
import 'package:sample_shopping_app/src/features/cart/data/repository/in_memory_cart_repository.dart';
import 'package:sample_shopping_app/src/features/order/infrastructure/repository/in_memory_order_repository.dart';
import 'package:sample_shopping_app/src/features/product_list/data/in_memory_product_repository.dart';
import 'package:sample_shopping_app/src/locator/repository_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  RepositoryLocator.instance.addAll(
    authenticationRepository: InMemoryAuthenticationRepository.instance,
    productRepository: InMemoryProductRepository(),
    cartRepository: InCartRepository.instance,
    orderRepository: InMemoryOrderRepository.instance,
  );
  runApp(const ProviderScope(child: MyApp()));
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
