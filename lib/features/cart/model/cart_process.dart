import 'package:cloud_firestore/cloud_firestore.dart';

class CartProcessModel {
  String id;
  int quantity;
  String prductID;
  Map<String, dynamic> selectedVariation;

  CartProcessModel(
      {required this.quantity,
      this.selectedVariation = const {},
      required this.prductID,
      this.id = ''});

  static CartProcessModel empty() =>
      CartProcessModel(quantity: 0, prductID: '');

  // Map<String, dynamic> toJson() {
  //   return {
  //     'quantity': quantity,

  //     'selectedVariation': selectedVariation
  //   };
  // }

  factory CartProcessModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    if (data.isNotEmpty) {
      return CartProcessModel(
        id: snapshot.id,
        quantity: data['Quantity'] as int,
        prductID: data['productId'] as String,
        selectedVariation: data['variations'] as Map<String, dynamic>,
      );
    }
    return CartProcessModel.empty();
  }
}
