import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_demo/features/product/model/product.dart';
import 'package:ecommerce_demo/utils/constants/enums.dart';
import 'package:flutter/services.dart';

import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../model/product_variation.dart';

class ProductRepository {
  final _db = FirebaseFirestore.instance.collection('Products');

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapShot = await _db.get();
      return snapShot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  //FeaturesProduct
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapShot =
          await _db.where('isFeatured', isEqualTo: true).limit(4).get();
      return snapShot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  //single_product
  Future<ProductModel> getTheProduct(String productId) async {
    try {
      final snapShot = await _db.doc(productId).get();
      return ProductModel.fromSnapshot(snapShot);
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong";
    }
  }

  //all_product
  Future<List<ProductModel>> getPaginationProduct([String? productId]) async {
    try {
      if (productId != null) {
        final lastProduct = await _db.doc(productId).get();
        final snapShot = await _db
            .orderBy('title')
            .startAfterDocument(lastProduct)
            .limit(6)
            .get();
        return snapShot.docs
            .map((doc) => ProductModel.fromSnapshot(doc))
            .toList();
      } else {
        final snapShot = await _db.orderBy('title').limit(6).get();
        return snapShot.docs
            .map((doc) => ProductModel.fromSnapshot(doc))
            .toList();
      }
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong";
    }
  }

  Future<List<ProductModel>> getBrandProducts(
      {required String brandName, int limit = -1}) async {
    try {
      final querySnapShot = limit == -1
          ? await _db.where('brand.Name', isEqualTo: brandName).get()
          : await _db
              .where('brand.Name', isEqualTo: brandName)
              .limit(limit)
              .get();
      final products = querySnapShot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ProductModel>> categoryProducts(String docId) async {
    try {
      final snapShot = await _db.where('categoryId', isEqualTo: docId).get();
      final products =
          snapShot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();

      return products;
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  List<Map<String, dynamic>> getSelectedVariation(
      List<ProductVariationModel> productVariation) {
    List<Map<String, dynamic>> selectedVariation = [];

    for (var variation in productVariation) {
      Map<String, dynamic> color = {};
      if (variation.attributeValues.containsKey('Color') &&
          variation.attributeValues.containsKey('Size')) {
        color.addAll({
          variation.attributeValues['Color']: {
            'Size': variation.attributeValues['Size'],
            'price': variation.price,
            'salePrice': variation.salePrice,
            'stoke': variation.stock,
            'image': variation.image
          }
        });
        selectedVariation.add(color);
      } else if (variation.attributeValues.containsKey('Color') &&
          variation.attributeValues.containsKey('Storage')) {
        color.addAll({
          variation.attributeValues['Color']: {
            'Storage': variation.attributeValues['Storage'],
            'price': variation.price,
            'salePrice': variation.salePrice,
            'stoke': variation.stock,
            'image': variation.image
          }
        });
        selectedVariation.add(color);
      } else {
        color.addAll({
          variation.attributeValues['Ram']: {
            'Storage': variation.attributeValues['Storage'],
            'price': variation.price,
            'salePrice': variation.salePrice,
            'stoke': variation.stock,
            'image': variation.image
          }
        });
        selectedVariation.add(color);
      }
    }
    return selectedVariation;
  }

  String getProductPrice(ProductModel product) {
    double smallPrice = double.infinity;
    double largestPrice = 0.0;

    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else if (product.productVariations != null) {
      for (var variation in product.productVariations!) {
        double maxValue;
        if (variation.salePrice.values.isEmpty) {
          maxValue = 0.0; // Or any other default value
        } else {
          maxValue = variation.salePrice.values.reduce(max);
        }
        double priceToConsider = maxValue > 0.0
            ? variation.salePrice.values.reduce(max)
            : variation.price.values.reduce(max).toDouble();
        // variation.salePrice[''] > 0.0 ? variation.salePrice : variation.price;

        if (priceToConsider < smallPrice) {
          smallPrice = priceToConsider;
        }

        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }
    }
    if (smallPrice == largestPrice) {
      return largestPrice.toString();
    } else {
      return '$smallPrice€ - $largestPrice€';
    }
  }

  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;

    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  sortProduct(String sortByValue, List<ProductModel> products) {
    try {
      switch (sortByValue) {
        case 'Name':
          products.sort((a, b) => a.title.compareTo(b.title));
          break;
        case 'Higher Price':
          products.sort((a, b) => b.price.compareTo(a.price));
          break;
        case 'Lower Price':
          products.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'Newest':
          products.sort((a, b) => a.date!.compareTo(b.date!));
        case 'Sale':
          products.sort((a, b) {
            if (b.salePrice > 0) {
              return b.salePrice.compareTo(a.salePrice);
            } else if (a.salePrice > 0) {
              return -1;
            } else {
              return 1;
            }
          });
        default:
          products.sort((a, b) => a.title.compareTo(b.title));
      }
    } catch (e) {
      return e.toString();
    }
  }
}
