// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_demo/utils/constants/enums.dart';

class AutoCompleteModel {
  final String? id;
  final String title;
  final String itemId;
  final String image;
  final AutoCompleteType type;

  AutoCompleteModel({
    this.id,
    required this.title,
    required this.itemId,
    required this.image,
    this.type = AutoCompleteType.product,
  });

  static AutoCompleteModel empty() =>
      AutoCompleteModel(title: '', itemId: '', image: '');

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'itemId': itemId,
      'image': image,
      'type': type.toString(),
    };
  }

  factory AutoCompleteModel.fromMap(Map<String, dynamic> map) {
    return AutoCompleteModel(
      title: map['title'] as String,
      itemId: map['itemId'] as String,
      image: map['image'],
      type: AutoCompleteType.values
          .firstWhere((element) => element.toString() == map['type']),
    );
  }

  factory AutoCompleteModel.fromSnapShot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    if (data.isNotEmpty) {
      return AutoCompleteModel(
        id: snapshot.id,
        title: data['title'] as String,
        itemId: data['itemId'] as String,
        image: data['image'],
        type: AutoCompleteType.values
            .firstWhere((element) => element.toString() == data['type']),
      );
    }

    return AutoCompleteModel.empty();
  }

  String toJson() => json.encode(toMap());

  factory AutoCompleteModel.fromJson(String source) =>
      AutoCompleteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
