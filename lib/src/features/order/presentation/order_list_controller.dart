import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/authentication/domain/repository/authentication_reporisory.dart';
import 'package:sample_shopping_app/src/features/order/application/order_application_service.dart';
import 'package:sample_shopping_app/src/features/order/application/order_data.dart';
import 'package:sample_shopping_app/src/features/order/domain/model/order.dart';
import 'package:sample_shopping_app/src/features/order/domain/repository/order_repository.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/repository/product_repository.dart';
import 'package:sample_shopping_app/src/locator/repository_locator.dart';

// final orderListControllerProvider =
// StateNotifierProvider<OrderListController, AsyncValue<List<OrderDataForOrderList>>>((ref) {
//   final authRepo = RepositoryLocator.instance.get<AuthenticationRepository>();
//   if (authRepo.currentUser == null) {
//     return OrderListController(orderDataList: []);
//   }
//
//   final userId = authRepo.currentUser!.id;
//   final List<String> orderIdList = ref.watch(orderListProvider.select((value) {
//     if (value.value == null) {
//       return [];
//     }
//
//     final orderList = value.value!.where((element) => element.userId == userId);
//     final productRepo = RepositoryLocator.instance.get<ProductRepository>();
//     for(final order in orderList) {
//       var product = await productRepo.fetch(order.productId);
//     }
//     return orderList.map((e) => e.id).toList();
//   }));
//   return OrderListController(orderDataList: orderIdList);
// });
//
// class OrderListController extends StateNotifier<AsyncValue<List<OrderDataForOrderList>>> {
//   OrderListController({required List<OrderDataForOrderList> orderDataList,})
//       : super(AsyncData(orderDataList));
// }

final orderDataListProvider =
    FutureProvider<List<OrderDataForOrderList>>((ref) async {
  final authRepo = RepositoryLocator.instance.get<AuthenticationRepository>();
  if (authRepo.currentUser == null) {
    return [];
  }

  final userId = authRepo.currentUser!.id;
  final List<Order> orderList =
      ref.watch(allOrderStreamProvider.select((value) {
    if (value.value == null) {
      return [];
    }

    return value.value!;
  }));

  final productRepo = RepositoryLocator.instance.get<ProductRepository>();
  final orderRepo = RepositoryLocator.instance.get<OrderRepository>();
  final List<OrderDataForOrderList> orderDataList = [];
  for (final order in orderList) {
    var product = await productRepo.fetch(order.productId);
    final status = await orderRepo.fetchOrderStatus(order.id);
    orderDataList.add(OrderDataForOrderList(
      userId: userId,
      dateTime: order.date,
      productName: product.name,
      productPrice: product.price,
      imageResource: product.imageResource,
      status: status!.status,
    ));
  }

  return orderDataList;
});
