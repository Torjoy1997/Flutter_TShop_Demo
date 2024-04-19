import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;
  List<String>? categoryID;
  BrandModel(
      {this.id = '',
      required this.image,
      required this.name,
      this.isFeatured,
      this.productsCount,
      this.categoryID});

  /// Empty Helper Function
  static BrandModel empty() => BrandModel(id: "", image: "", name: "");

  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured,
      'categoryID': categoryID
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();

    return BrandModel(
        id: data['id'] ?? '',
        image: data['Image'],
        name: data['Name'],
        productsCount: data['ProductsCount'],
        isFeatured: data['IsFeatured']);
  }

  factory BrandModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      return BrandModel(
        id: document.id,
        image: data?['Image'],
        name: data?['Name'],
        productsCount: data?['ProductsCount'],
        isFeatured: data?['IsFeatured'],
        categoryID: data?['categoryID'] != null
            ? (data?['categoryID'] as List<dynamic>)
                // Cast to String for reference IDs
                .map((refId) {
                return refId.toString();
              }).toList()
            : null,
      );
    } else {
      return BrandModel.empty();
    }
  }
}
