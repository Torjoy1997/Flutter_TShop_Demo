part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductFetchEvent extends ProductEvent {
  final String productId;

  const ProductFetchEvent({this.productId = ''});
}

class ProductPaginateEvent extends ProductEvent {
  final String? productId;

  const ProductPaginateEvent({this.productId});
}

class SetThumbnailImageEvent extends ProductEvent {
  final String imageUrl;

  const SetThumbnailImageEvent({required this.imageUrl});
}

class SetVariationEvent extends ProductEvent{
  final Map<String,dynamic> variations;

  const SetVariationEvent({ this.variations = const {}});
}