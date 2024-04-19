import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentMethodModel {
  String id;
  String name;
  String image;

  PaymentMethodModel({required this.image, required this.name, this.id = ''});

  static PaymentMethodModel empty() => PaymentMethodModel(image: '', name: '');

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'image': image};
  }

  factory PaymentMethodModel.fromJson(Map<String, dynamic> data) {
    return PaymentMethodModel(image: data['image'], name: data['name']);
  }

  factory PaymentMethodModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return PaymentMethodModel(
          id: document.id, image: data['image'], name: data['name']);
    }
    return PaymentMethodModel.empty();
  }
}
