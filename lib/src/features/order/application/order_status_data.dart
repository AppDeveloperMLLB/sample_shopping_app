import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sample_shopping_app/src/features/order/domain/repository/order_repository.dart';

part 'order_status_data.freezed.dart';

@freezed
class OrderStatusData with _$OrderStatusData {
  const OrderStatusData._();
  const factory OrderStatusData({
    required String orderId,
    required OrderStatus status,
  }) = _OrderStatusData;
}
