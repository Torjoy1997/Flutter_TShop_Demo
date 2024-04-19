part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}
//all_products
final class ProductFetchLoading extends ProductState {}

final class ProductFetchLoaded extends ProductState {
  final List<ProductModel> products;

  const ProductFetchLoaded({this.products = const <ProductModel>[]});

  @override
  List<Object> get props => [products];
}

//Single
final class SingleProductFetchLoaded extends ProductState {
  final ProductModel product;

  const SingleProductFetchLoaded({required this.product});

  @override
  List<Object> get props => [product];
}

//error-message
final class ProductFetchError extends ProductState {
  final String errorMessage;
  final String? errorCode;

  const ProductFetchError({required this.errorMessage, this.errorCode});
  @override
  List<Object> get props => [errorMessage];
}

//for_paginate_product
final class ProductPaginateLoading extends ProductState {}

final class ProductPaginateLoaded extends ProductState {
  final List<ProductModel> paginateProducts;

  const ProductPaginateLoaded({this.paginateProducts = const <ProductModel>[]});

  @override
  List<Object> get props => [paginateProducts];
}

//for_set_image
final class SetThumbnailImageInit extends ProductState {}

final class SetThumbnailImageState extends ProductState {
  final String imageUrl;

  const SetThumbnailImageState({required this.imageUrl});
  @override
  List<Object> get props => [imageUrl];
}


//for setting variation value
final class SetVariationValueState extends ProductState{
  final Map<String,dynamic> variations;

  const SetVariationValueState({ this.variations = const {} });
  @override
  List<Object> get props => [variations];
}