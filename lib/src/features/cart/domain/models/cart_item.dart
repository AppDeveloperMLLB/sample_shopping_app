import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';

@freezed
class CartItem with _$CartItem {
  const CartItem._();
  const factory CartItem({
    required String userId,
    required String productId,
    required int num,
  }) = _CartItem;

  CartItem increment() {
    return copyWith(num: this.num + 1);
  }

  CartItem decrement() {
    if (this.num <= 1) {
      throw Exception("Can not decrement");
    }

    return copyWith(num: this.num - 1);
  }
}
