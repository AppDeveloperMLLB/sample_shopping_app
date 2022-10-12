import 'package:flutter/material.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/model/product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchAll();
  Future<Product> fetch(String productId);
  Future<Image> getImage(String imageResource);
}
