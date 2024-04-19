import 'package:cloud_firestore/cloud_firestore.dart';

import '../../product/model/product.dart';

class CategoryModel {
  String id;
  final String name;
  final Map<String, List<String>> brandedProduct;
  final List<ProductModel> categoryProduct;

  CategoryModel(
      {this.id = '',
      required this.name,
      this.brandedProduct = const {},
      this.categoryProduct = const []});

  factory CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return CategoryModel(
      id: snapshot.id,
      name: data['name'] as String,
      brandedProduct: (data['brandedProduct'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(
                key,
                (value as List).cast<String>(),
              )),
      categoryProduct: (data['categoryProduct'] as List)
          .map((product) => ProductModel.fromSnapshot(product))
          .toList(),
    );
  }
}
