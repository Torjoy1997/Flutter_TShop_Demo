import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_demo/features/order/model/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderRepository {
  final _db = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  Future<List<OrderModel>?> fetchUserOrders() async {
    try {
      final userId = _firebaseAuth.currentUser!.uid;
      if (userId.isEmpty) {
        throw 'unable to find user information';
      }

      final orderSnap =
          await _db.collection('Users').doc(userId).collection('Orders').get();
      if (orderSnap.docs.isNotEmpty) {
        return orderSnap.docs
            .map((doc) => OrderModel.fromSnapShot(doc))
            .toList();
      }
      return null;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> saveTheUserOrder(OrderModel order) async {
    try {
      final userId = _firebaseAuth.currentUser!.uid;
      if (userId.isEmpty) {
        throw 'unable to find user information';
      }
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .add(order.toMap());
    } catch (e) {
      throw e.toString();
    }
  }
}
