import 'package:ecommerce_demo/features/store/model/brand.dart';

class CartItemModel {
  String id;
  int quantity;
  String image;
  String title;
  Map<String, dynamic>? selectedVariation;
  double price;
  BrandModel brandData;

  CartItemModel(
      {this.id = '',
      required this.quantity,
      required this.image,
      required this.title,
      this.selectedVariation,
      this.price = 0.0,
      required this.brandData});

  static CartItemModel empty() => CartItemModel(
      quantity: 0, image: '', title: '', brandData: BrandModel.empty());

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'quantity': quantity,
      'image': image,
      'price': price,
      'selectedVariation': selectedVariation,
      'brand': brandData.toJson()
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> data) {
    if (data.isNotEmpty) {
      return CartItemModel(
          quantity: data['quantity'],
          image: data['image'],
          title: data['title'],
          selectedVariation: data['selectedVariation'] ?? {},
          brandData: BrandModel.fromJson(data['brand']));
    }
    return CartItemModel.empty();
  }

  // factory CartItemModel.fromSnapshot(DocumentSnapshot snapshot) {
  //   final data = snapshot.data() as Map<String, dynamic>;
  //   if (data.isNotEmpty) {
  //     return CartItemModel(
  //       id: snapshot.id,
  //       quantity: data['quantity'] as int,
  //       prductItem: data['productId'] as ProductModel,
  //       selectedVariation: data['selectedVariation'] as Map<String, dynamic>?,
  //     );
  //   }
  //   return CartItemModel.empty();
  // }
}
