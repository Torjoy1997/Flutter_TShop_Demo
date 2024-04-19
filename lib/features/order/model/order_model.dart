import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_demo/features/Address/model/address.dart';
import 'package:ecommerce_demo/features/cart/model/payment_model.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../cart/model/cart_item_model.dart';

class OrderModel {
  final String id;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;
  final PaymentMethodModel paymentMethod;
  final AddressModel billingAddress;

  OrderModel({
    this.id = '',
    this.status = OrderStatus.processing,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    required this.paymentMethod,
    required this.billingAddress,
    this.deliveryDate,
  });

  static OrderModel empty() => OrderModel(
      id: '',
      status: OrderStatus.processing,
      items: [],
      totalAmount: 0.0,
      orderDate: DateTime.now(),
      paymentMethod: PaymentMethodModel.empty(),
      billingAddress: AddressModel.empty());

  String get formattedOrderDate =>
      AppHelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? AppHelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Processing';

  Map<String, dynamic> toMap() {
    return {
      'Status': status.toString(),
      'TotalAmount': totalAmount,
      'OrderDate': orderDate,
      'PaymentMethod': paymentMethod.toMap(),
      'BillingAddress': billingAddress.toJson(),
      'DeliveryDate': deliveryDate,
      'items': items.map((item) => item.toJson()).toList()
    };
  }

  factory OrderModel.fromSnapShot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    if (data.isNotEmpty) {
      return OrderModel(
          id: snapshot.id,
          status: OrderStatus.values
              .firstWhere((element) => element.toString() == data['Status']),
          items: (data['items'] as List<dynamic>)
              .map((itemData) => CartItemModel.fromJson(itemData))
              .toList(),
          totalAmount: data['TotalAmount'],
          orderDate: (data['OrderDate'] as Timestamp).toDate(),
          paymentMethod: PaymentMethodModel.fromJson(data['PaymentMethod']),
          billingAddress: AddressModel.fromJson(data['BillingAddress']),
          deliveryDate: data['DeliveryDate'] != null
              ? (data['DeliveryDate'] as Timestamp).toDate()
              : null);
    }
    return OrderModel.empty();
  }
}
