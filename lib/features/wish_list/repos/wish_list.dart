import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_demo/features/product/model/product.dart';
import 'package:ecommerce_demo/features/product/repos/product.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../utils/exceptions/format_exceptions.dart';

class WishListRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance.collection('Users');

  final ProductRepository _productRepository = ProductRepository();

  Future<List<ProductModel>> getWishProduct() async {
    try {
      final List<ProductModel> productWishList = [];
      if (_firebaseAuth.currentUser != null) {
        final wishSnap = await _db
            .doc(_firebaseAuth.currentUser!.uid)
            .collection('WishList')
            .get();
        if (wishSnap.docs.isNotEmpty) {
          for (var documentData in wishSnap.docs) {
            final productData = await _productRepository
                .getTheProduct(documentData.data()['productId']);
            productWishList.add(productData);
          }
        }
      }

      return productWishList;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> addWish(String productId) async {
    try {
      if (_firebaseAuth.currentUser != null) {
        await _db
            .doc(_firebaseAuth.currentUser!.uid)
            .collection('WishList')
            .add({'productId': productId});
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
        final wishRef = await _db
            .doc(_firebaseAuth.currentUser!.uid)
            .collection('WishList')
            .where('productId', isEqualTo: productId)
            .get();
        await _db
            .doc(_firebaseAuth.currentUser!.uid)
            .collection('WishList')
            .doc(wishRef.docs.first.id)
            .delete();
      }
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw 'Something went wrong .please try later';
    }
  }

  Future<List<String>> isFavoriteList() async {
    try {
      List<String> isFavoriteList = [];
      if (_firebaseAuth.currentUser != null) {
        final wishRef = await _db
            .doc(_firebaseAuth.currentUser!.uid)
            .collection('WishList')
            .get();

        for (var documentWish in wishRef.docs) {
          isFavoriteList.add(documentWish.data()['productId']);
        }
      }
      return isFavoriteList;
    } catch (e) {
      throw e.toString();
    }
  }

  Stream<List<String>> isFavoriteListStrem() {
    try {
      return _db
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('WishList')
          .snapshots()
          .map((event) => event.docs
              .map((doc) => doc.data()['productId'].toString())
              .toList());
    } catch (e) {
      throw e.toString();
    }
  }
}
