import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_demo/features/Address/model/address.dart';
import 'package:ecommerce_demo/features/cart/model/payment_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/image_strings.dart';

class AddressRepository {
  final _db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  //text edit controllers
  final nameOfUser = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postCode = TextEditingController();
  final city = TextEditingController();
  final stateOfCountry = TextEditingController();
  final country = TextEditingController();

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  Future<List<AddressModel>> fetchUserAddress() async {
    try {
      final userId = auth.currentUser!.uid;
      if (userId.isEmpty) {
        throw 'unable to find user information';
      }
      final result =
          await _db.collection('Users').doc(userId).collection('Address').get();
      return result.docs
          .map(
              (documentSnapshot) => AddressModel.fromSnapShot(documentSnapshot))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Stream<List<AddressModel>> fetchStreamUserAddress() {
    try {
      final userId = auth.currentUser!.uid;
      if (userId.isEmpty) {
        throw 'unable to find user information';
      }

      return _db
          .collection('Users')
          .doc(userId)
          .collection('Address')
          .snapshots()
          .map((documentSnapshot) {
        return documentSnapshot.docs
            .map((doc) => AddressModel.fromSnapShot(doc))
            .toList();
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> addUserAddress() async {
    try {
      final userId = auth.currentUser!.uid;
      if (userId.isEmpty) {
        throw 'unable to find user information';
      }

      AddressModel userAddress = submitAddressForm();

      final result =
          await _db.collection('Users').doc(userId).collection('Address').get();
      if (result.docs.isNotEmpty) {
        await _db
            .collection('Users')
            .doc(userId)
            .collection('Address')
            .add(userAddress.toJson());
        resetFormField();
      } else {
        await _db
            .collection('Users')
            .doc(userId)
            .collection('Address')
            .add({...userAddress.toJson(), 'seclectedAddress': true});
        resetFormField();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> removeUserAddress(String userAddressId) async {
    try {
      final userId = auth.currentUser!.uid;
      if (userId.isEmpty) {
        throw 'unable to find user information';
      }

      await _db
          .collection('Users')
          .doc(userId)
          .collection('Address')
          .doc(userAddressId)
          .delete();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> changeTheAddress(String addressId) async {
    try {
      final userId = auth.currentUser!.uid;
      if (userId.isEmpty) {
        throw 'unable to find user information';
      }

      final result =
          await _db.collection('Users').doc(userId).collection('Address').get();
      final List<String> addressIds = result.docs.map((e) => e.id).toList();

      for (var userAddressId in addressIds) {
        if (userAddressId == addressId) {
          await _db
              .collection('Users')
              .doc(userId)
              .collection('Address')
              .doc(addressId)
              .update({'seclectedAddress': true});
        } else {
          await _db
              .collection('Users')
              .doc(userId)
              .collection('Address')
              .doc(userAddressId)
              .update({'seclectedAddress': false});
        }
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> addPaymentMethod(
      {required PaymentMethodModel paymentData, }) async {
    try {
      final userId = auth.currentUser!.uid;
      if (userId.isEmpty) {
        throw 'unable to find user information';
      }
      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('PaymentMethod')
          .get();
      if (result.docs.isEmpty){
        await _db
            .collection('Users')
            .doc(userId)
            .collection('PaymentMethod')
            .add(paymentData.toMap());
      }else{
        String paymentId = result.docs.first.id;
        await _db
            .collection('Users')
            .doc(userId)
            .collection('PaymentMethod')
        .doc(paymentId).update(paymentData.toMap());

      }

    } catch (e) {
      throw e.toString();
    }
  }

  Future<PaymentMethodModel> getPaymentMethod() async {
    try {
      final userId = auth.currentUser!.uid;
      if (userId.isEmpty) {
        throw 'unable to find user information';
      }

      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('PaymentMethod')
          .get();
      if (result.docs.isNotEmpty) {
        return result.docs
            .map((doc) => PaymentMethodModel.fromSnapshot(doc))
            .first;
      }
      return PaymentMethodModel(
          image: AppImages.creditCard, name: 'Credit Card');
    } catch (e) {
      throw e.toString();
    }
  }

  Stream<PaymentMethodModel?> changePaymentMethod() {
    try {
      final userId = auth.currentUser!.uid;
      if (userId.isEmpty) {
        throw 'unable to find user information';
      }


      return _db
          .collection('Users')
          .doc(userId)
          .collection('PaymentMethod')
          .snapshots()
          .map((documentSnapshot) {
            if(documentSnapshot.docs.isNotEmpty){
             return documentSnapshot.docs
                  .map((doc) => PaymentMethodModel.fromSnapshot(doc)).first;
            }else{
              return null;
            }

      });
    } catch (e) {
      throw e.toString();
    }
  }

  AddressModel submitAddressForm() {
    return AddressModel(
        name: nameOfUser.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: stateOfCountry.text.trim(),
        postalCode: postCode.text.trim(),
        country: country.text.trim());
  }

  void resetFormField() {
    nameOfUser.clear();
    phoneNumber.clear();
    street.clear();
    postCode.clear();
    city.clear();
    country.clear();
    stateOfCountry.clear();
    addressFormKey.currentState?.reset();
  }
}
