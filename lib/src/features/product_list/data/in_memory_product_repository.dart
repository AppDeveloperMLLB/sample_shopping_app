import 'package:flutter/material.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/model/product.dart';
import 'package:sample_shopping_app/src/features/product_list/domain/repository/product_repository.dart';

class InMemoryProductRepository implements ProductRepository {
  List<Product> products = [
    const Product(
      id: "0001",
      name: "Product1",
      price: 1000,
      imageResource: "asset/images/product1.png",
    ),
    const Product(
      id: "0002",
      name: "Product2",
      price: 2000,
      imageResource: "asset/images/product2.png",
    ),
    const Product(
      id: "0003",
      name: "Product3",
      price: 3000,
      imageResource: "asset/images/product3.png",
    ),
    const Product(
      id: "0004",
      name: "Product4",
      price: 500,
      imageResource: "asset/images/product4.png",
    ),
    const Product(
      id: "0005",
      name: "Product5",
      price: 1500,
      imageResource: "asset/images/product5.png",
    ),
    const Product(
      id: "0006",
      name: "Product6",
      price: 2500,
      imageResource: "asset/images/product6.png",
    ),
  ];

  @override
  Future<List<Product>> fetchAll() async {
    await Future.delayed(const Duration(seconds: 3));
    return products;
  }

  @override
  Future<Product> fetch(String productId) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = products.indexWhere((element) => element.id == productId);
    return products[index];
  }

  @override
  Future<Image> getImage(String imageResource) async {
    return Image.asset(imageResource);
  }
}
