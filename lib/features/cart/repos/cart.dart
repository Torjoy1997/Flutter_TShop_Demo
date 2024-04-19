import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecommerce_demo/features/cart/model/cart_process.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';

class CartRepository {
  final _db = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  Future<List<CartProcessModel>?> fetchCartItem() async {
    try {
      if (_firebaseAuth.currentUser != null) {
        final cartSnap = await _db
            .collection('Users')
            .doc(_firebaseAuth.currentUser!.uid)
            .collection('Carts')
            .get();

        return cartSnap.docs
            .map((doc) => CartProcessModel.fromSnapshot(doc))
            .toList();
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw e.toString();
    }
  }

  Stream<List<CartProcessModel>> fetchStreamCartItem() {
    try {
      final userId = _firebaseAuth.currentUser!.uid;
      if (userId.isEmpty) {
        throw 'unable to find user information';
      }
      return _db
          .collection('Users')
          .doc(userId)
          .collection('Carts')
          .snapshots()
          .map((documentSnap) {
        return documentSnap.docs
            .map((doc) => CartProcessModel.fromSnapshot(doc))
            .toList();
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> cartAddItems(Map<String, dynamic> cartItem) async {
    try {
      if (_firebaseAuth.currentUser != null) {
        await _db
            .collection('Users')
            .doc(_firebaseAuth.currentUser!.uid)
            .collection('Carts')
            .add(cartItem);
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw 'Something went wrong .please try later';
    }
  }

  Future<void> cartItemRemove(String cartId) async {
    try {
      if (_firebaseAuth.currentUser != null) {
        await _db
            .collection('Users')
            .doc(_firebaseAuth.currentUser!.uid)
            .collection('Carts')
            .doc(cartId)
            .delete();
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw 'Something went wrong .please try later';
    }
  }

  Future<void> allCartItemRemove() async {
    try {
      final cartItem = await fetchCartItem();
      final cartIds = cartItem?.map((item) => item.id).toList();
      if (_firebaseAuth.currentUser != null && cartIds != null) {
        for (var cartId in cartIds) {
          await _db
              .collection('Users')
              .doc(_firebaseAuth.currentUser!.uid)
              .collection('Carts')
              .doc(cartId)
              .delete();
        }
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw 'Something went wrong .please try later';
    }
  }
}
