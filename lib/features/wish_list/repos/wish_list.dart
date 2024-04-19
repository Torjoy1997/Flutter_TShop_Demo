import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_demo/features/product/model/product.dart';
import 'package:ecommerce_demo/features/product/repos/product.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../utils/exceptions/format_exceptions.dart';

class WishListRepository {
  final _db = FirebaseFirestore.instance.collection('WishList');
  final _firebaseAuth = FirebaseAuth.instance;
  final ProductRepository _productRepository = ProductRepository();

  Future<List<ProductModel>?> getWishProduct() async {
    try {
      final productIdMap = await isFavoriteList();
      final productIds = productIdMap.keys;
      final List<ProductModel> productWishList = [];

      if (productIds.isNotEmpty) {
        for (var productId in productIds) {
          final productData = await _productRepository.getTheProduct(productId);
          productWishList.add(productData);
        }

        return productWishList;
      }
      return null;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> addWish(String productId) async {
    try {
      if (_firebaseAuth.currentUser != null) {
        final wishSnap = await _db.doc(_firebaseAuth.currentUser!.uid).get();
        if (wishSnap.data()!['productId'] != null) {
          final List<String> productIds =
              wishSnap.data()!['productId'].cast<String>().toList();
          await _db.doc(_firebaseAuth.currentUser!.uid).update({
            'productId': [...productIds, productId]
          });
        } else {
          await _db.doc(_firebaseAuth.currentUser!.uid).set({
            'productId': [productId]
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw 'Something went wrong .please try later';
    }
  }

  Future<void> removeWish(String productId) async {
    try {
      if (_firebaseAuth.currentUser != null) {
        final wishSnap = await _db.doc(_firebaseAuth.currentUser!.uid).get();
        if (wishSnap.data()!['productId'] != null) {
          final List<String> productIds =
              wishSnap.data()!['productId'].cast<String>().toList();
          int index = productIds.indexOf(productId);
          productIds.removeAt(index);
          await _db.doc(_firebaseAuth.currentUser!.uid).update({
            'productId': [...productIds]
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw 'Something went wrong .please try later';
    }
  }

  Future<Map<String, bool>> isFavoriteList() async {
    try {
      if (_firebaseAuth.currentUser != null) {
        final wishSnap = await _db.doc(_firebaseAuth.currentUser!.uid).get();
        if (wishSnap.data()!['productId'] != null) {
          final List<String> productIds =
              wishSnap.data()!['productId'].cast<String>().toList();
          return {for (var productId in productIds) productId: true};
        }
      }
      return {};
    } catch (e) {
      throw e.toString();
    }
  }
}
