// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_demo/features/product/model/product_attribute.dart';
import 'package:ecommerce_demo/features/product/model/product_variation.dart';

import '../../store/model/brand.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;
  ProductModel({
    required this.id,
    required this.stock,
    this.sku,
    required this.price,
    required this.title,
    this.date,
    this.salePrice = 0.0,
    required this.thumbnail,
    this.isFeatured,
    this.brand,
    this.description,
    this.categoryId = '',
    this.images,
    required this.productType,
    this.productAttributes,
    this.productVariations,
  });

  static ProductModel empty() => ProductModel(
        id: "",
        title: "",
        stock: 0,
        price: 0,
        thumbnail: "",
        productType: "",
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'stock': stock,
      'sku': sku,
      'price': price,
      'title': title,
      'date': date?.toIso8601String(),
      'salePrice': salePrice,
      'thumbnail': thumbnail,
      'isFeatured': isFeatured,
      'brand': brand!.toJson(),
      'description': description,
      'categoryId': categoryId,
      'images': images ?? [],
      'productType': productType,
      'productAttributes':
          productAttributes?.map((attribute) => attribute.toJson()).toList(),
      'productVariations':
          productVariations?.map((variation) => variation.toJson()).toList(),
    };
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ProductModel(
        id: document.id,
        stock: data['stock'] ?? 0,
        sku: data['sku'],
        price: (data['price'] ?? 0.0).toDouble(),
        title: data['title'] ?? '',
        date: data['date'] != null ? DateTime.parse(data['date']) : null,
        salePrice: (data['salePrice'] ?? 0.0).toDouble(),
        thumbnail: data['thumbnail'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        brand:
            data['brand'] != null ? BrandModel.fromJson(data['brand']) : null,
        description: data['description'],
        categoryId: data['categoryId'],
        images: data['images'] != null ? List<String>.from(data['images']) : [],
        productType: data['productType'] ?? '',
        productAttributes: (data['productAttributes'] as List<dynamic>?)
            ?.map((attr) => ProductAttributeModel.fromJson(attr))
            .toList(),
        productVariations: (data['productVariations'] as List<dynamic>?)
            ?.map((variant) => ProductVariationModel.fromJson(variant))
            .toList(),
      );
    } else {
      return ProductModel.empty();
    }
  }

  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    if (document.exists) {
      final data = document.data() as Map<String, dynamic>;
      return ProductModel(
        id: document.id,
        stock: data['stock'] ?? 0,
        sku: data['sku'],
        price: (data['price'] ?? 0.0).toDouble(),
        title: data['title'] ?? '',
        date: data['date'] != null ? DateTime.parse(data['date']) : null,
        salePrice: (data['salePrice'] ?? 0.0).toDouble(),
        thumbnail: data['thumbnail'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        brand:
            data['brand'] != null ? BrandModel.fromJson(data['brand']) : null,
        description: data['description'],
        categoryId: data['categoryId'],
        images: data['images'] != null ? List<String>.from(data['images']) : [],
        productType: data['productType'] ?? '',
        productAttributes: (data['productAttributes'] as List<dynamic>?)
            ?.map((attr) => ProductAttributeModel.fromJson(attr))
            .toList(),
        productVariations: (data['productVariations'] as List<dynamic>?)
            ?.map((variant) => ProductVariationModel.fromJson(variant))
            .toList(),
      );
    } else {
      return ProductModel.empty();
    }
  }
}
