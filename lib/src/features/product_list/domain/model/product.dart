import 'package:freezed_annotation/freezed_annotation.dart';
part 'product.freezed.dart';

@freezed
abstract class Product implements _$Product {
  const Product._();
  const factory Product({
    required String id,
    required String name,
    required int price,
    required String imageResource,
  }) = _Product;
}
