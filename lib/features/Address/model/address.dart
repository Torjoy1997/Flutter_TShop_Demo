import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_demo/utils/formatters/formatter.dart';

class AddressModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final bool seclectedAddress;

  AddressModel(
      {this.id = '',
      required this.name,
      required this.phoneNumber,
      required this.street,
      required this.city,
      required this.state,
      required this.postalCode,
      required this.country,
      this.seclectedAddress = false});

  String get formattedPhoneNo =>
      AppDefineFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(
      name: '',
      phoneNumber: '',
      street: '',
      city: '',
      state: '',
      postalCode: '',
      country: '');

  @override
  String toString() {
    return '$street, $city, $state $postalCode, $country';
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'seclectedAddress': seclectedAddress
    };
  }

  factory AddressModel.fromJson(Map<String, dynamic> data) {
    return AddressModel(
        id: data['id'] as String,
        name: data['name'] as String,
        phoneNumber: data['phoneNumber'] as String,
        street: data['street'] as String,
        city: data['city'] as String,
        state: data['state'] as String,
        postalCode: data['postalCode'] as String,
        country: data['country'] as String,
        seclectedAddress: data['seclectedAddress'] as bool);
  }

  factory AddressModel.fromSnapShot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return AddressModel(
        id: snapshot.id,
        name: data['name'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        street: data['street'] ?? '',
        city: data['city'] ?? '',
        state: data['state'] ?? '',
        postalCode: data['postalCode'] ?? '',
        country: data['country'] ?? '',
        seclectedAddress: data['seclectedAddress']);
  }
}
