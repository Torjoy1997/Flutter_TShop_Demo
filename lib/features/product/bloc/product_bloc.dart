import 'package:ecommerce_demo/features/product/repos/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_demo/features/product/model/product.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  ProductBloc(this._productRepository) : super(ProductFetchLoading()) {
    on<ProductFetchEvent>(_onProductFetch);
    on<ProductPaginateEvent>(_onProductPaginate);
    on<SetThumbnailImageEvent>((event, emit) =>
        emit(SetThumbnailImageState(imageUrl: event.imageUrl)));
    on<SetVariationEvent>((event, emit) {
      if(event.variations.isNotEmpty){
        emit(SetVariationValueState(variations: event.variations));
      }
    });
  }

  void _onProductFetch(
      ProductFetchEvent event, Emitter<ProductState> emit) async {
    try {
      if (event.productId.isEmpty) {
        final products = await _productRepository.getFeaturedProducts();
        emit(ProductFetchLoaded(products: products));
      } else {
        emit(ProductFetchLoading());
        final product = await _productRepository.getTheProduct(event.productId);
        emit(SingleProductFetchLoaded(product: product));
      }
    } catch (e) {
      emit(ProductFetchError(errorMessage: e.toString()));
    }
  }

  void _onProductPaginate(
      ProductPaginateEvent event, Emitter<ProductState> emit) async {
    try {
      emit(ProductPaginateLoading());
      if (event.productId != null) {
        final products =
            await _productRepository.getPaginationProduct(event.productId);
        emit(ProductPaginateLoaded(paginateProducts: products));
      } else {
        final products = await _productRepository.getPaginationProduct();
        emit(ProductPaginateLoaded(paginateProducts: products));
      }
    } catch (e) {
      emit(ProductFetchError(errorMessage: e.toString()));
    }
  }
}
