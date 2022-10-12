import 'package:sample_shopping_app/src/features/product_list/domain/model/product.dart';

class ProductInCart {
  final Product product;
  final int num;

  ProductInCart({required this.product, required this.num});
}
