import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_demo/features/product/repos/product.dart';
import 'package:flutter/services.dart';

import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../product/model/product.dart';
import '../model/brand.dart';
import '../model/category.dart';

class StoreRepository {
  final _db = FirebaseFirestore.instance;
  final ProductRepository _productRepository = ProductRepository();

  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapShot = await _db.collection('Brands').get();

      return snapShot.docs
          .map((document) => BrandModel.fromSnapShot(document))
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

  Future<List<ProductModel>> fetchBrandProducts(String brandName) async {
    try {
      final products =
          await _productRepository.getBrandProducts(brandName: brandName);
      return products;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<CategoryModel> fetchCategoryProduct(String categoryName) async {
    try {
      final categorySnap = await _db
          .collection('Category')
          .where('name', isEqualTo: categoryName)
          .get();
      final products =
          await _productRepository.categoryProducts(categorySnap.docs.first.id);
      final brandSnapshot = await _db
          .collection('Brands')
          .where('categoryID', arrayContains: categorySnap.docs.first.id)
          .get();
      final brands = brandSnapshot.docs
          .map((document) => BrandModel.fromSnapShot(document))
          .toList();

      final categoryBrand = getJustBrandProductImage(brands, products);

      return CategoryModel(
          name: categoryName,
          brandedProduct: categoryBrand,
          categoryProduct: products);
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

  Map<String, List<String>> getJustBrandProductImage(
      List<BrandModel> brands, List<ProductModel> products) {
    final brandNameList = brands.map((brand) => brand.name).toList();

    Map<String, List<String>> categoryBrand = {};
    for (var name in brandNameList) {
      final List<String> imageList = [];
      for (var product in products) {
        if (product.brand?.name == name) {
          imageList.add(product.thumbnail);
        }
      }
      categoryBrand = {...categoryBrand, name: imageList};
    }
    return categoryBrand;
  }

  Future<List<CategoryModel>> getCategoryProducts() async {
    final List<CategoryModel> categoryData = [];
    for (var category in [
      'Sports',
      'Furniture',
      'Electronics',
      'Clothes',
      'Cosmetics'
    ]) {
      final CategoryModel data = await fetchCategoryProduct(category);
      categoryData.add(data);
    }

    return categoryData;
  }
}
