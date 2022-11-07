import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/authentication/domain/repository/authentication_reporisory.dart';
import 'package:sample_shopping_app/src/features/order/application/order_application_service.dart';
import 'package:sample_shopping_app/src/features/order/application/order_data.dart';
import 'package:sample_shopping_app/src/locator/repository_locator.dart';

final orderListControllerProvider =
StateNotifierProvider<OrderListController, AsyncValue<List<String>>>((ref) {
  final authRepo = RepositoryLocator.instance.get<AuthenticationRepository>();
  if (authRepo.currentUser == null) {
    return OrderListController(orderIdList: []);
  }

  final userId = authRepo.currentUser!.id;
  final List<String> orderIdList = ref.watch(orderListProvider.select((value) {
    if (value.value == null) {
      return [];
    }

    final orderList = value.value!.where((element) => element.userId == userId);
    return orderList.map((e) => e.id).toList();
  }));
  return OrderListController(orderIdList: orderIdList);
});

class OrderListController extends StateNotifier<AsyncValue<List<String>>> {
  OrderListController({required List<String> orderIdList})
      : super(AsyncData(orderIdList));
}
