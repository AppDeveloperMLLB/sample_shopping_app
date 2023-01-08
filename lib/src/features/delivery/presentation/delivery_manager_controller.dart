import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/authentication/domain/repository/authentication_reporisory.dart';
import 'package:sample_shopping_app/src/features/delivery/application/delivery_application_service.dart';
import 'package:sample_shopping_app/src/features/delivery/domain/delivery_status.dart';
import 'package:sample_shopping_app/src/features/delivery/presentation/order_data.dart';
import 'package:sample_shopping_app/src/features/order/application/order_application_service.dart';
import 'package:sample_shopping_app/src/features/order/domain/model/order.dart';
import 'package:sample_shopping_app/src/features/order/domain/repository/order_repository.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/repository/product_repository.dart';
import 'package:sample_shopping_app/src/locator/repository_locator.dart';

final deliveryManagerControllerProvider =
    StateNotifierProvider<DeliveryManagerController, void>(
  (ref) => DeliveryManagerController(),
);

class DeliveryManagerController extends StateNotifier<void> {
  DeliveryManagerController() : super(null);

  // 3. override the [build] method to return a [FutureOr]
  @override
  FutureOr<void> build() async {
    // 4. return a value (or do nothing if the return type is void)
  }

  Future<void> changeDeliveryState(
      String orderId, DeliveryStatus status) async {
    if (status == DeliveryStatus.delivered) {
      await DelivelyApplicationService().delivery(orderId);
      return;
    }

    await DelivelyApplicationService().undelivery(orderId);
  }
}

final orderDataListProvider = FutureProvider<List<OrderData>>((ref) async {
  final authRepo = RepositoryLocator.instance.get<AuthenticationRepository>();
  if (authRepo.currentUser == null) {
    return [];
  }

  final List<Order> orderList =
      ref.watch(allOrderStreamProvider.select((value) {
    if (value.value == null) {
      return [];
    }

    return value.value!;
  }));

  final productRepo = RepositoryLocator.instance.get<ProductRepository>();
  final orderRepo = RepositoryLocator.instance.get<OrderRepository>();
  final List<OrderData> orderDataList = [];
  for (final order in orderList) {
    final status = await orderRepo.fetchOrderStatus(order.id);
    orderDataList.add(OrderData(
      orderId: order.id,
      orderStatus: status!.status,
    ));
  }

  return orderDataList;
});
