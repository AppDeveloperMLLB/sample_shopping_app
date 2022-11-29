import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final deliveryManagerControllerProvider =
    AsyncNotifierProvider<DeliveryManagerController, void>(() {
  return DeliveryManagerController();
});

class DeliveryManagerController extends AsyncNotifier<void> {
  // 3. override the [build] method to return a [FutureOr]
  @override
  FutureOr<void> build() async {
    // 4. return a value (or do nothing if the return type is void)
  }

  Future<void> changeDeliveryState() async {}
}
