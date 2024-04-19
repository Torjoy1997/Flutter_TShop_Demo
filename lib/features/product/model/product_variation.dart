// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_demo/utils/helpers/helper_functions.dart';

class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  Map<String, int> price;
  Map<String, double> salePrice;
  Map<String, int> stock;
  Map<String, dynamic> attributeValues;
  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = const {},
    this.salePrice = const {},
    this.stock = const {},
    required this.attributeValues,
  });

  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'sku': sku,
      'image': image,
      'description': description,
      'price': price,
      'salePrice': salePrice,
      'stock': stock,
      'attributeValues': attributeValues,
    };
  }

  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
        id: data['id'] ?? '',
        sku: data['sku'] ?? '',
        image: data['image'] ?? '',
        description: data['description'] ?? '',
        price: Map<String, int>.from(data['price']),
        salePrice: AppHelperFunctions.converToMapDouble(data['salePrice']),
        stock: Map<String, int>.from(data['stock']),
        attributeValues: Map<String, dynamic>.from(data['attributeValues']));
  }
}
